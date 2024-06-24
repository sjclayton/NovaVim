local map = require('core.helpers').map
local on_attach = require('plugins.config.lsp.keymaps').on_attach

return function()
  vim.g.haskell_tools = {
    ---@type HaskellLspClientOpts
    hls = {
      ---@param client number LSP client ID
      ---@param bufnr number Buffer number
      ---@param ht HaskellTools = require('haskell-tools')
      on_attach = function(client, bufnr, ht)
        on_attach(client, bufnr)
      end,
    },
  }

  local ok, telescope = pcall(require, 'telescope')

  if ok then
    telescope.load_extension('ht')
  end
end
