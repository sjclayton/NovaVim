return function()
  local opts = {
    scope = 'buffer',
    modes = { 'i', 'ic', 'ix', 'R', 'Rc', 'Rx', 'Rv', 'Rvc', 'Rvx' },
    blending = {
      threshold = 1.0,
      colorcode = '#000000',
      hlgroup = {
        'Normal',
        'background',
      },
    },
    warning = {
      alpha = 0.4,
      offset = 0,
      colorcode = '#6e6a86',
      -- hlgroup = {
      --   'Normal',
      --   'background',
      -- },
    },
    extra = {
      follow_tw = nil,
    },
  }
  require('deadcolumn').setup(opts)
end
