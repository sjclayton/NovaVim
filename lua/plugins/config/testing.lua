return function()
  local neotest_ns = vim.api.nvim_create_namespace('neotest')
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
        return message
      end,
    },
  }, neotest_ns)

  local opts = {
    -- log_level = vim.log.levels.TRACE,
    adapters = {
      require('neotest-go')({
        recursive_run = true,
      }),
      require('neotest-haskell'),
      require('neotest-rust'),
      require('neotest-zig'),
    },
    icons = {
      passed = '',
      failed = '',
      unknown = '',
    },
    summary = {
      open = 'botright vsplit | vertical resize 35',
    },
  }

  require('neotest').setup(opts)
end
