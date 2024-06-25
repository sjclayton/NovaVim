local map = require('core.helpers').map
local on_attach = require('plugins.config.lsp.keymaps').on_attach

return function()
  local ht = require('haskell-tools')

  vim.g.haskell_tools = {
    ---@type HaskellLspClientOpts
    hls = {
      ---@param client number LSP client ID
      ---@param bufnr number Buffer number
      on_attach = function(client, bufnr)
        -- import general LSP keymaps
        on_attach(client, bufnr)
        -- set server specific keymaps
        map('n', '<leader>he', function()
          ht.lsp.buf_eval_all()
        end, { desc = 'Eval all (Haskell)', buffer = bufnr })
        map('n', '<leader>hs', function()
          ht.hoogle.hoogle_signature()
        end, { desc = 'Search type signature (Haskell)', buffer = bufnr })
        map('n', '<leader>rf', function()
          ht.repl.toggle(vim.api.nvim_buf_get_name(bufnr))
        end, { desc = 'Toggle REPL current buffer (Haskell)', buffer = bufnr })
        map('n', '<leader>rq', function()
          ht.repl.quit()
        end, { desc = 'Quit REPL (Haskell)', buffer = bufnr })
      end,
    },
  }

  local ok, telescope = pcall(require, 'telescope')

  if ok then
    telescope.load_extension('ht')
  end
end
