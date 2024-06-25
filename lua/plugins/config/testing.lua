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
      ['neotest-golang'] = { dap_go_enabled = true },
      ['neotest-haskell'] = {},
      ['neotest-rust'] = {},
      ['neotest-zig'] = {},
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

  if opts.adapters then
    local adapters = {}
    for name, config in pairs(opts.adapters or {}) do
      if type(name) == 'number' then
        if type(config) == 'string' then
          config = require(config)
        end
        adapters[#adapters + 1] = config
      elseif config ~= false then
        local adapter = require(name)
        if type(config) == 'table' and not vim.tbl_isempty(config) then
          local meta = getmetatable(adapter)
          if adapter.setup then
            adapter.setup(config)
          elseif meta and meta.__call then
            adapter(config)
          else
            error('Adapter ' .. name .. ' does not support setup')
          end
        end
        adapters[#adapters + 1] = adapter
      end
    end
    opts.adapters = adapters
  end

  require('neotest').setup(opts)
end
