local get_hex = require('core.util').get_hex
local theme_hl = require('core.helpers').theme_hl

return function()
  local cc_color = theme_hl(get_hex('LineNr', 'fg'))

  local opts = {
    scope = 'buffer',
    ---@type string[]|fun(mode: string): boolean
    modes = function(mode)
      return mode:find('^[ictRss\x13]') ~= nil
    end,
    blending = {
      threshold = 1.0,
      colorcode = '#000000',
      hlgroup = { 'Normal', 'bg' },
    },
    warning = {
      alpha = 0.4,
      offset = 0,
      colorcode = cc_color,
      -- hlgroup = { 'Normal', 'bg' },
    },
    extra = {
      follow_tw = nil,
    },
  }

  require('deadcolumn').setup(opts)

  vim.api.nvim_create_augroup('reload_deadcolumn', { clear = true })
  vim.api.nvim_create_autocmd('Colorscheme', {
    group = 'reload_deadcolumn',
    callback = function()
      vim.cmd('Lazy reload deadcolumn.nvim')
    end,
  })
end
