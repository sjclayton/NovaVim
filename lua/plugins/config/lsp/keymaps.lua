local map = require('core.helpers').map

local M = {}

M.on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }

  -- Set general LSP keymaps
  if M.has(bufnr, 'references') then
    opts.desc = 'Show LSP references'
    map('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  end

  if M.has(bufnr, 'declaration') then
    opts.desc = 'Go to declaration'
    map('n', 'gD', vim.lsp.buf.declaration, opts)
  end

  if M.has(bufnr, 'definition') then
    opts.desc = 'Show LSP definitions'
    map('n', 'gd', function()
      require('telescope.builtin').lsp_definitions({ reuse_win = true })
    end, opts)
  end

  if M.has(bufnr, 'implementation') then
    opts.desc = 'Show LSP implementations'
    map('n', 'gI', function()
      require('telescope.builtin').lsp_implementations({ reuse_win = true })
    end, opts)
  end

  if M.has(bufnr, 'typeDefinition') then
    opts.desc = 'Show LSP type definitions'
    map('n', 'gy', function()
      require('telescope.builtin').lsp_type_definitions({ reuse_win = true })
    end, opts)
  end

  if M.has(bufnr, 'codeLens') then
    opts.desc = 'Run an available codelens'
    map('n', '<leader>cl', vim.lsp.codelens.run, opts)
  end

  if M.has(bufnr, 'codeAction') then
    opts.desc = 'Code action'
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    opts.desc = 'Source action'
    map('n', '<leader>cA', function()
      vim.lsp.buf.code_action({ context = { only = { 'source' }, diagnostics = {} } })
    end, opts)
  end

  if M.has(bufnr, 'rename') then
    opts.desc = 'Rename variable'
    map('n', '<leader>cr', vim.lsp.buf.rename, opts)
  end

  if M.has(bufnr, 'hover') then
    opts.desc = 'Show hover documentation'
    map('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
  end

  if M.has(bufnr, 'signatureHelp') then
    opts.desc = 'Show signature help'
    map('n', 'gK', vim.lsp.buf.signature_help, opts)
  end

  -- Show buffer diagnostics and line diagnostics
  opts.desc = 'Show buffer diagnostics'
  map('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
  opts.desc = 'Show line diagnostics'
  map('n', '<leader>d', vim.diagnostic.open_float, opts)

  -- Go to previous and next diagnostic
  opts.desc = 'Go to previous diagnostic'
  map('n', '[d', vim.diagnostic.goto_prev, opts)
  opts.desc = 'Go to next diagnostic'
  map('n', ']d', vim.diagnostic.goto_next, opts)

  -- Toggle inlay hints
  if M.has(bufnr, 'inlayHint') then
    opts.desc = 'Toggle inlay hints'
    map('n', '<leader>ci', function()
      bufnr = bufnr or 0
      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
      if inlay_hint.enable then
        vim.lsp.inlay_hint.enable(bufnr, not inlay_hint.is_enabled())
      else
        vim.lsp.inlay_hint(bufnr, nil)
      end
    end, opts)
  end
end

---@param method string
function M.has(buffer, method)
  method = method:find('/') and method or 'textDocument/' .. method
  local clients = require('core.util').get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

return M
