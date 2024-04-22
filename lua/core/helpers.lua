local Util = require('lazy.core.util')

---@param state boolean?
local function notify(field, state)
  if state == false then
    Util.warn(field .. ' off', { title = 'Toggle' })
  else
    Util.info(field .. ' on', { title = 'Toggle' })
  end
end

local M = {}

-- Helper for keymaps
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Helper for dynamically setting highlights on based on colorscheme
---@param default table|string?
---@param primary table|string?
---@param secondary table|string?
function M.theme_hl(default, primary, secondary)
  if vim.g.colors_name == Primary_Colorscheme then
    return primary or default
  elseif vim.g.colors_name == Secondary_Colorscheme then
    return secondary or default
  else
    return default or nil
  end
end

-- Helper for toggling vim options
---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle_opt(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      ---@diagnostic disable-next-line: no-unknown
      vim.opt_local[option] = values[2]
    else
      ---@diagnostic disable-next-line: no-unknown
      vim.opt_local[option] = values[1]
    end
    return Util.info('Set ' .. option .. ' to ' .. vim.opt_local[option]:get(), { title = 'Option' })
  end
  ---@diagnostic disable-next-line: no-unknown
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      notify(option)
    else
      notify(option, false)
    end
  end
end

local toggle_state = {}
-- Helper for enabling/disabling or toggling commands
---@param name string Name of the feature to toggle, used as display name for notifications.
---@param cmds table Contains commands required to enable/disable or toggle this feature.
---Expects: { enable=string, disable=string or toggle=string }
---@param default boolean? optional - Whether the feature is considered enabled by default. Default: false if not provided.
---@param silent boolean? optional - Whether to show notifications about toggled features.
function M.toggle_cmd(name, cmds, default, silent)
  local enable = cmds.enable
  local disable = cmds.disable
  local toggle = cmds.toggle

  default = default or false

  if not (enable and disable or toggle) then
    error("Couldn't toggle " .. name .. ': missing command in cmds table.', 2)
  end

  toggle_state[name] = not toggle_state[name]

  local function enabler()
    if enable then
      vim.cmd(enable)
    else
      vim.cmd(toggle)
    end
    if not silent then
      notify(name)
    end
  end

  local function disabler()
    if disable then
      vim.cmd(disable)
    else
      vim.cmd(toggle)
    end
    if not silent then
      notify(name, false)
    end
  end

  if not default then
    if toggle_state[name] then
      enabler()
    else
      disabler()
    end
  else
    if toggle_state[name] then
      disabler()
    else
      enabler()
    end
  end

  return toggle_state[name]
end

local nu = { number = true, relativenumber = true }
function M.number()
  if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
    nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    notify('number', false)
  else
    vim.opt_local.number = nu.number
    vim.opt_local.relativenumber = nu.relativenumber
    notify('number')
  end
end

local enabled = true
function M.diagnostics()
  if vim.diagnostic.is_enabled then
    enabled = vim.diagnostic.is_enabled()
  end

  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    notify('Diagnostics')
  else
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    notify('Diagnostics', false)
  end
end

---@param buf? number
---@param value? boolean
function M.inlay_hints(buf, value)
  local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if type(ih) == 'function' then
    ih(buf, value)
  elseif type(ih) == 'table' and ih.enable then
    if value == nil then
      value = not ih.is_enabled(buf)
    end
    ih.enable(value, { bufnr = buf })
  end
end

return M
