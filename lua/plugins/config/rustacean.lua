local map = require('core.helpers').map
local on_attach = require('plugins.config.lsp.keymaps').on_attach

return function()
  local opts = {
    tools = {
      executor = 'toggleterm',
      hover_actions = {
        replace_builtin_hover = false,
        max_width = 80,
        max_height = 18,
        auto_focus = true,
      },
    },
    server = {
      on_attach = function(client, bufnr)
        -- import general LSP keymaps
        on_attach(client, bufnr)
        -- set server specific keymap overrides
        map({ 'n', 'v' }, '<leader>ca', function()
          vim.cmd('RustLsp codeAction')
        end, { desc = 'Code action', buffer = bufnr })
        map('n', 'K', function()
          vim.cmd('RustLsp hover actions')
        end, { desc = 'Show hover docs/actions', buffer = bufnr })
        -- set server specific keymaps
        map('n', '<leader>cro', function()
          vim.cmd('RustLsp openCargo')
        end, { desc = 'Open Cargo.toml', buffer = bufnr })
        map('n', '<leader>ce', function()
          vim.cmd('RustLsp expandMacro')
        end, { desc = 'Expand macro (Rust)', buffer = bufnr })
        map('n', '<leader>cR', function()
          vim.cmd('RustLsp runnables')
        end, { desc = 'Runnables (Rust)', buffer = bufnr })
        map('n', '<leader>dR', function()
          vim.cmd('RustLsp debuggables')
        end, { desc = 'Debuggables (Rust)', buffer = bufnr })

        vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
          group = vim.api.nvim_create_augroup('rust__codelenses', { clear = true }),
          pattern = { '*.rs' },
          callback = function()
            vim.lsp.codelens.refresh()
          end,
        })
      end,
      settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          -- Add clippy lints for Rust.
          checkOnSave = true,
          procMacro = {
            enable = true,
            ignored = {
              ['async-trait'] = { 'async_trait' },
              ['napi-derive'] = { 'napi' },
              ['async-recursion'] = { 'async_recursion' },
            },
          },
        },
      },
    },
  }
  vim.g.rustaceanvim = vim.tbl_deep_extend('force', {}, opts or {})
end
