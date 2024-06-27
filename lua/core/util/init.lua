local M = {}

---
--- Load some LazyVim util functions early
---

-- Options for LazyFile event (M.lazy_file())
M.lazy_file_events = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }

function M.fg(name)
  ---@type {foreground?:number}?
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format('#%06x', fg) }
end

---@param plugin string
function M.has(plugin)
  return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

function M.lazy_file()
  -- This autocmd will only trigger when a file was loaded from the cmdline.
  -- It will render the file as quickly as possible.
  vim.api.nvim_create_autocmd('BufReadPost', {
    once = true,
    callback = function(event)
      -- Skip if we already entered vim
      if vim.v.vim_did_enter == 1 then
        return
      end

      -- Try to guess the filetype (may change later on during Neovim startup)
      local ft = vim.filetype.match({ buf = event.buf })
      if ft then
        -- Add treesitter highlights and fallback to syntax
        local lang = vim.treesitter.language.get_lang(ft)
        if not (lang and pcall(vim.treesitter.start, event.buf, lang)) then
          vim.bo[event.buf].syntax = ft
        end

        -- Trigger early redraw
        vim.cmd([[redraw]])
      end
    end,
  })

  -- Add support for the LazyFile event
  local Event = require('lazy.core.handler.event')

  Event.mappings.LazyFile = { id = 'LazyFile', event = M.lazy_file_events }
  Event.mappings['User LazyFile'] = Event.mappings.LazyFile
end

---@param name "autocmds" | "keymaps" | "options"
function M.load(name)
  local function _load(mod)
    if require('lazy.core.cache').find(mod)[1] then
      LazyVim.try(function()
        require(mod)
      end, { msg = 'Failed loading ' .. mod })
    end
  end
  _load('core.' .. name)
  if vim.bo.filetype == 'lazy' then
    -- NOTE: NovaVim may have overwritten options of the Lazy UI, so reset this here
    vim.cmd([[do VimResized]])
  end
  local pattern = 'NovaVim' .. name:sub(1, 1):upper() .. name:sub(2)
  vim.api.nvim_exec_autocmds('User', { pattern = pattern, modeline = false })
end

---@alias lsp.Client.filter {id?: number, bufnr?: number, name?: string, method?: string, filter?:fun(client: lsp.Client):boolean}
---@param opts? lsp.Client.filter
function M.get_clients(opts)
  local ret = {} ---@type lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client lsp.Client
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local Config = require('lazy.core.config')
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

function M.on_rename(from, to)
  local clients = M.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method('workspace/willRenameFiles') then
      ---@diagnostic disable-next-line: invisible
      local resp = client.request_sync('workspace/willRenameFiles', {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end
end

-- this will return a function that calls telescope.
-- cwd will default to core.util.get_root()
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend('force', { cwd = LazyVim.root.get() }, opts or {})
    if builtin == 'files' then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. '/.git') then
        opts.show_untracked = true
        builtin = 'git_files'
      else
        builtin = 'find_files'
      end
    end
    if opts.cwd and opts.cwd ~= vim.loop.cwd() then
      opts.attach_mappings = function(_, map)
        map('i', '<a-c>', function()
          local action_state = require('telescope.actions.state')
          local line = action_state.get_current_line()
          M.telescope(
            params.builtin,
            vim.tbl_deep_extend('force', {}, params.opts or {}, { cwd = false, default_text = line })
          )()
        end)
        return true
      end
    end

    require('telescope.builtin')[builtin](opts)
  end
end

---
--- END of Lazy util functions
---

function M.dap_run_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input('Run with args: ', table.concat(args, ' ')) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], ' ')
  end
  return config
end

function M.get_hex(name, attr)
  local hl = M.get_hl(name)
  if not hl then
    return
  end
  return hl[attr]
end
function M.get_hl(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  if not hl then
    return
  end
  if hl.fg and type(hl.fg) == 'number' then
    hl.fg = M.hex(hl.fg)
  end
  if hl.bg and type(hl.bg) == 'number' then
    hl.bg = M.hex(hl.bg)
  end
  if hl.sp and type(hl.sp) == 'number' then
    hl.sp = M.hex(hl.sp)
  end
  return hl
end

---@param rgb integer
---@return string hex
function M.hex(rgb)
  local band, lsr = bit.band, bit.rshift

  local r = lsr(band(rgb, 0xff0000), 16)
  local g = lsr(band(rgb, 0x00ff00), 8)
  local b = band(rgb, 0x0000ff)

  local res = ('#%02x%02x%02x'):format(r, g, b)
  return res
end

function M.lsp_client_names()
  local active_clients = vim.lsp.get_clients()
  local client_names = {}
  for _, client in pairs(active_clients or {}) do
    local buf = vim.api.nvim_get_current_buf()
    -- only return attached buffers
    if vim.lsp.buf_is_attached(buf, client.id) then
      table.insert(client_names, client.name)
    end
  end

  if not vim.tbl_isempty(client_names) then
    table.sort(client_names)
  end

  if #client_names < 1 then
    return ''
  end

  local client_str = table.concat(client_names, ', ')
  if client_str:len() < 1 then
    return
  end

  return client_str
end

function M.treesitter_available(bufnr)
  if not package.loaded['nvim-treesitter'] then
    return false
  end
  if type(bufnr) == 'table' then
    bufnr = bufnr.bufnr
  end
  local parsers = require('nvim-treesitter.parsers')
  return parsers.has_parser(parsers.get_buf_lang(bufnr or vim.api.nvim_get_current_buf()))
end

return M
