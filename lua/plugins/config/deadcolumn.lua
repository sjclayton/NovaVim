return function()
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
      colorcode = '#6e6a86',
      -- hlgroup = { 'Normal', 'bg' },
    },
    extra = {
      follow_tw = nil,
    },
  }
  require('deadcolumn').setup(opts)
end
