local map = require('core.helpers').map

local M = {}

M.on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }

  -- Set general LSP keymaps
  if M.has(bufnr, 'references') then
    map('n', 'gr', '<cmd>Telescope lsp_references<CR>', 'Show LSP References', opts)
  end

  if M.has(bufnr, 'declaration') then
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration', opts)
  end

  if M.has(bufnr, 'definition') then
    map('n', 'gd', function()
      require('telescope.builtin').lsp_definitions({ reuse_win = true })
    end, 'Show LSP definitions', opts)
  end

  if M.has(bufnr, 'implementation') then
    map('n', 'gI', function()
      require('telescope.builtin').lsp_implementations({ reuse_win = true })
    end, 'Show LSP implementations', opts)
  end

  if M.has(bufnr, 'typeDefinition') then
    map('n', 'gy', function()
      require('telescope.builtin').lsp_type_definitions({ reuse_win = true })
    end, 'Show LSP type definitions', opts)
  end

  if M.has(bufnr, 'codeLens') then
    map('n', '<leader>cl', vim.lsp.codelens.run, 'Run an available codelens', opts)
  end

  if M.has(bufnr, 'codeAction') then
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action', opts)
    map('n', '<leader>cA', LazyVim.lsp.action.source, 'Source action', opts)
  end

  if M.has(bufnr, 'rename') then
    map('n', '<leader>cv', vim.lsp.buf.rename, 'Rename', opts)
  end

  if M.has(bufnr, 'hover') then
    map('n', 'K', vim.lsp.buf.hover, 'Show hover documentation', opts) -- show documentation for what is under cursor
  end

  if M.has(bufnr, 'signatureHelp') then
    map('n', 'gK', vim.lsp.buf.signature_help, 'Show signature help', opts)
  end

  -- Show buffer diagnostics and line diagnostics
  map('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', 'Show buffer diagnostics', opts)
  map('n', '<leader>cd', vim.diagnostic.open_float, 'Show line diagnostics', opts)

  -- Go to previous and next diagnostic
  map('n', '[d', vim.diagnostic.goto_prev, 'Goto previous diagnostic', opts)
  map('n', ']d', vim.diagnostic.goto_next, 'Goto next diagnostic', opts)

  -- Toggle inlay hints
  if M.has(bufnr, 'inlayHint') then
    map('n', '<leader>uh', function()
      LazyVim.toggle.inlay_hints()
    end, 'Toggle inlay hints', opts)
  end
end

---@param method string
function M.has(buffer, method)
  method = method:find('/') and method or 'textDocument/' .. method
  local clients = LazyVim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

return M
