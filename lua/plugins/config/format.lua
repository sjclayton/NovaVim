return function()
  local opts = {
    -- Define formatters
    formatters_by_ft = {
      go = { 'goimports-reviser', 'goimports', 'gofumpt' },
      lua = { 'stylua' },
      -- javascript = { { "prettierd", "prettier" } },
      -- javascript = { { 'eslint_d', 'eslint' } },
      javascript = { 'standardjs' },
      rust = { 'rustfmt' },
      ['_'] = { 'trim_whitespace' },
    },
    -- Set up format-on-save
    format_on_save = { async = false, timeout_ms = 3000, lsp_fallback = true },
    -- Customize formatters
    formatters = {
      ['goimports-reviser'] = {
        command = 'goimports-reviser',
        inherit = false,
        args = { '-set-alias', '-rm-unused', '$FILENAME' },
        stdin = false,
      },
    },
  }

  require('conform').setup(opts)
end
