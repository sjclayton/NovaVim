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
      float_win_config = {
        border = 'rounded',
      },
    },
    server = {
      on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }

        -- import general LSP keymaps
        on_attach(client, bufnr)
        -- set server specific keymap overrides
        map({ 'n', 'v' }, '<leader>ca', function()
          vim.cmd('RustLsp codeAction')
        end, 'Code action', opts)
        map('n', 'K', function()
          vim.cmd('RustLsp hover actions')
        end, 'Show hover docs/actions', opts)
        -- set server specific keymaps
        map('n', '<leader>cro', function()
          vim.cmd('RustLsp openCargo')
        end, 'Open Cargo.toml', opts)
        map('n', '<leader>ce', function()
          vim.cmd('RustLsp expandMacro')
        end, 'Expand macro (Rust)', opts)
        map('n', '<leader>cR', function()
          vim.cmd('RustLsp runnables')
        end, 'Runnables (Rust)', opts)
        map('n', '<leader>dR', function()
          vim.cmd('RustLsp debuggables')
        end, 'Debuggables (Rust)', opts)

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
