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
        local opts = { buffer = bufnr }

        -- import general LSP keymaps
        on_attach(client, bufnr)
        -- set server specific keymap overrides
        map('n', '<leader>lS', function()
          ht.lsp.start()
        end, 'Start LSP', opts)
        map('n', '<leader>ls', function()
          ht.lsp.stop()
        end, 'Stop LSP', opts)
        map('n', '<leader>lr', function()
          ht.lsp.restart()
        end, 'Restart LSP', opts)
        -- set server specific keymaps
        map('n', '<leader>he', function()
          ht.lsp.buf_eval_all()
        end, 'Eval all (Haskell)', opts)
        map('n', '<leader>hs', function()
          ht.hoogle.hoogle_signature()
        end, 'Search type signature (Haskell)', opts)
        map('n', '<leader>rf', function()
          ht.repl.toggle(vim.api.nvim_buf_get_name(bufnr))
        end, 'Toggle REPL current buffer (Haskell)', opts)
        map('n', '<leader>rq', function()
          ht.repl.quit()
        end, 'Quit REPL (Haskell)', opts)
      end,
    },
  }

  local ok, telescope = pcall(require, 'telescope')

  if ok then
    telescope.load_extension('ht')
  end
end
