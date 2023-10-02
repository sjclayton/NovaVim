return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'folke/neodev.nvim', opts = {} },
    {
      'hrsh7th/cmp-nvim-lsp',
      cond = function()
        return require('core.util').has('nvim-cmp')
      end,
    },
  },
  config = function()
    local icons = require('core.icons')

    -- import lspconfig plugin
    local lspconfig = require('lspconfig')

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    local map = vim.keymap.set -- for conciseness

    local opts = { noremap = true, silent = true }

    vim.diagnostic.config({
      virtual_text = {
        -- Only display errors w/ virtual text
        severity = vim.diagnostic.severity.ERROR,
        -- Prepend with diagnostic source if there is more than one attached to the buffer
        -- (e.g. (eslint) Error: blah blah blah)
        source = 'if_many',
        signs = false,
      },
      float = {
        severity_sort = true,
        source = 'if_many',
        border = 'rounded',
      },
      severity_sort = true,
    })

    -- use built-in formatting for these LSP servers
    local builtin_format = { 'pylsp' }

    local lsp_formatting = function(bufnr)
      vim.lsp.buf.format({
        filter = function(client)
          if vim.tbl_contains(builtin_format, client.name) then
            return client.name
          else
            return client.name == 'null-ls'
          end
        end,
        bufnr = bufnr,
      })
    end

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    local on_attach = function(client, bufnr)
      -- setup auto-format on save
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting()
          end,
        })
      end

      opts.buffer = bufnr

      -- set keybinds
      opts.desc = 'Show LSP references'
      map('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

      opts.desc = 'Go to declaration'
      map('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = 'Show LSP definitions'
      map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

      opts.desc = 'Show LSP implementations'
      map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

      opts.desc = 'Show LSP type definitions'
      map('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

      opts.desc = 'See available code actions'
      map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = 'Smart rename'
      map('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = 'Show buffer diagnostics'
      map('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

      opts.desc = 'Show line diagnostics'
      map('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = 'Go to previous diagnostic'
      map('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = 'Go to next diagnostic'
      map('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = 'Show documentation for what is under cursor'
      map('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = 'Toggle Inlay Hints'
      map('n', '<leader>ci', function()
        vim.lsp.inlay_hint(0, nil)
      end, opts)

      opts.desc = 'Restart LSP'
      map('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = icons.diagnostics
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- configure css server
    lspconfig['cssls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure gopls server
    lspconfig['gopls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      --- @diagnostic disable-next-line : unused-local
      require('core.util').on_attach(function(client, bufnr)
        if client.name == 'gopls' then
          -- workaround to hl semanticTokens -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end
        end
      end),
      settings = {
        gopls = {
          semanticTokens = true,
          usePlaceholders = true,
          analyses = { unusedparams = true },
          staticcheck = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
      init_options = { usePlaceholders = true },
      filetypes = { 'go', 'gomod' },
    })

    -- configure html server
    lspconfig['html'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['jsonls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure python server (pylsp)
    lspconfig['pylsp'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pylsp = {
          plugins = {
            pylsp_black = {
              cache_config = true,
              enabled = true,
              line_length = 119,
            },
            flake8 = {
              enabled = true,
              maxLineLength = 119,
            },
            mypy = {
              enabled = true,
            },
            pycodestyle = {
              enabled = false,
            },
            pyflakes = {
              enabled = false,
            },
          },
        },
      },
    })

    -- configure typescript server
    lspconfig['tsserver'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          suggest = {
            includeCompletionsForModuleExports = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          suggest = {
            includeCompletionsForModuleExports = true,
          },
        },
      },
    })

    -- configure lua server (with special settings)
    lspconfig['lua_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { 'vim' },
          },
          format = { enable = false },
          hint = {
            enable = true,
            arrayIndex = 'Disable',
          },
          workspace = {
            checkThirdParty = false,
            -- make language server aware of runtime files
            library = {
              -- [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              -- [vim.fn.stdpath('config') .. '/lua'] = true,
            },
          },
        },
      },
    })

    -- Enable inlay hints on LspAttach
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function()
        vim.lsp.inlay_hint(0, true)
      end,
    })
  end,
}
