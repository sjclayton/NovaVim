return function()
  local opts = {
    check_ts = true,
    enable_check_bracket_line = false,
    fast_wrap = {},
    ts_config = {
      lua = { 'string' }, -- it will not add a pair on that treesitter node
    },
  }

  require('nvim-autopairs').setup(opts)

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end
