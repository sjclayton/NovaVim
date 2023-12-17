return function()
  local util = require('core.util')
  local icons = require('core.icons')

  local lspconfig = require('lspconfig')
  local mason_lsp = require('mason-lspconfig')
  local cmp_lsp = require('cmp_nvim_lsp')

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
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
      },
    },
    severity_sort = true,
  })

  local on_attach = function(client, bufnr)
    opts.buffer = bufnr

    -- Set keybinds
    opts.desc = 'Show LSP references'
    map('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

    opts.desc = 'Go to declaration'
    map('n', 'gD', vim.lsp.buf.declaration, opts)

    opts.desc = 'Show LSP definitions'
    map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

    opts.desc = 'Show LSP implementations'
    map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

    opts.desc = 'Show LSP type definitions'
    map('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

    opts.desc = 'Run an available codelens'
    -- see available code actions, in visual mode will apply to selection
    map('n', '<leader>cl', vim.lsp.codelens.run, opts)

    opts.desc = 'See available code actions'
    -- see available code actions, in visual mode will apply to selection
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

    opts.desc = 'Smart rename'
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)

    opts.desc = 'Show buffer diagnostics'
    map('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

    opts.desc = 'Show line diagnostics'
    map('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = 'Go to previous diagnostic'
    map('n', '[d', vim.diagnostic.goto_prev, opts)

    opts.desc = 'Go to next diagnostic'
    map('n', ']d', vim.diagnostic.goto_next, opts)

    opts.desc = 'Show hover documentation'
    map('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = 'Toggle Inlay Hints'
    if vim.bo[bufnr].filetype == 'rust' then
      map('n', '<leader>ci', function()
        require('core.helpers').toggle(
          'Inlay hints',
          { enable = 'RustDisableInlayHints', disable = 'RustEnableInlayHints' }
        )
      end, opts)
    else
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

    -- opts.desc = 'Format file'
    -- map('n', '<leader>cf', function()
    --   lsp_formatting(0)
    -- end, opts)

    opts.desc = 'Reload LSP'
    map('n', '<leader>rl', ':LspRestart<CR>', opts)
  end

  -- used to enable autocompletion (assign to every lsp server config)
  local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Mason LSP Config
  mason_lsp.setup({
    ensure_installed = { 'bashls', 'gopls', 'lua_ls', 'tsserver' },
  })

  -- configure bashls server
  lspconfig['bashls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- configure gopls server
  lspconfig['gopls'].setup({
    formatting = false,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    --- @diagnostic disable-next-line : unused-local
    on_attach = function(client, bufnr)
      -- HACK: Workaround to hl semanticTokens -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
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
      on_attach(client, bufnr)
    end,
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
        semanticTokens = true,
      },
    },
  })

  -- configure python server (pylsp)
  -- lspconfig['pylsp'].setup({
  --   capabilities = capabilities,
  --   on_attach = on_attach,
  --   settings = {
  --     pylsp = {
  --       plugins = {
  --         pylsp_black = {
  --           cache_config = true,
  --           enabled = true,
  --           line_length = 119,
  --         },
  --         pyls_isort = {
  --           enabled = true,
  --         },
  --         flake8 = {
  --           enabled = true,
  --           maxLineLength = 119,
  --         },
  --         mypy = {
  --           enabled = true,
  --         },
  --         mccabe = {
  --           enabled = false,
  --         },
  --         autopep8 = {
  --           enabled = false,
  --         },
  --         pycodestyle = {
  --           enabled = false,
  --         },
  --         pyflakes = {
  --           enabled = false,
  --         },
  --         yapf = {
  --           enabled = false,
  --         },
  --       },
  --     },
  --   },
  -- })

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
        format = { enable = false },
        hint = {
          enable = true,
          arrayIndex = 'Disable',
        },
        workspace = {
          maxPreload = 1500,
          checkThirdParty = 'Disable',
        },
      },
    },
  })

  --configure zig server
  lspconfig['zls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
