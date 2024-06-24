return function()
  require('lint').linters_by_ft = {
    javascript = { 'standardjs' },
    -- typescript = { 'eslint_d' },
    go = { 'golangcilint' },
  }

  vim.api.nvim_create_augroup('nvim-lint', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
    group = 'nvim-lint',
    callback = function()
      require('lint').try_lint()
    end,
  })
end
