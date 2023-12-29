return function()
  local icons = require('core.icons')

  local lspconfig = require('lspconfig')
  local mason_lsp = require('mason-lspconfig')
  local cmp_lsp = require('cmp_nvim_lsp')

  -- pull in general keymaps for on_attach
  local on_attach = require('plugins.config.lsp.keymaps').on_attach

  -- used to enable autocompletion (assign to every lsp server config)
  local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Mason LSP Config
  mason_lsp.setup({
    ensure_installed = { 'bashls', 'gopls', 'lua_ls', 'jedi_language_server', 'taplo', 'tsserver' },
  })

  -- Diagnostic format settings
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
    -- NOTE: For future use config in Neovim 0.11.0
    -- signs = {
    --   text = {
    --     [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
    --     [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
    --     [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
    --     [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
    --   },
    -- },
    severity_sort = true,
  })

  -- Diagnostic sign settings
  local signs = icons.diagnostics
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

  -- Enable inlay hints on LspAttach (for selected langs)
  local inlay_ft = {
    'go',
    -- 'rust',
  }
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[buf].filetype

      if vim.tbl_contains(inlay_ft, filetype) then
        vim.lsp.inlay_hint.enable(buf, true)
      end
    end,
  })

  -- configure bash server
  lspconfig['bashls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- configure go server
  lspconfig['gopls'].setup({
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
      vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('go__codelenses', { clear = true }),
        pattern = { '*.go', '*.mod' },
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
      on_attach(client, bufnr)
    end,
    settings = {
      gopls = {
        codelenses = {
          gc_details = true,
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
          compositeLiteralFields = false,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = false,
          rangeVariableTypes = true,
        },
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        semanticTokens = true,
        usePlaceholders = true,
        directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
      },
    },
  })

  -- configure python server
  lspconfig['jedi_language_server'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      diagnostics = {
        enable = false,
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

  -- configure toml server (taplo)
  lspconfig['taplo'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
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

  -- configure zig server (manually installed)
  lspconfig['zls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
