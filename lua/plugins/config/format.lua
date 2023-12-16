return function()
  local opts = {
    -- Define your formatters
    formatters_by_ft = {
      go = { 'goimports', 'gofmt' },
      lua = { 'stylua' },
      -- javascript = { { "prettierd", "prettier" } },
      -- python = { "isort", "black" },
      rust = { 'rustfmt' },
      ['_'] = { 'trim_whitespace' },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 3000, lsp_fallback = true },
    -- Customize formatters
    -- formatters = {
    --   shfmt = {
    --     prepend_args = { "-i", "2" },
    --   },
    -- },
  }

  require('conform').setup(opts)
end
