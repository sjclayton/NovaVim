return function()
  local opts = {
    leader = ' ', -- the key you want to use as the leader, default is space
    homerow = 2, -- the row you want to use as the homerow, default is 2
    powerFingers = { 3, 4, 6, 7 }, -- the fingers you want to use as the powerfingers, default is {2,3,6,7}
    keyboardLayout = 'qwerty', -- the keyboard layout you use, default is qwerty
    customMaps = {
      ['map'] = {
        modeIndex = 1,
        lhsIndex = 2,
        rhsIndex = 3,
        optsIndex = 4,
        method = 'function_call',
      },
      -- If you use whichkey.register with an alias eg wk.register
      ['wk.register'] = {
        method = 'which_key',
      },
      -- If you use lazy.nvim's keys property to configure keymaps in your plugins
      ['lazy'] = {
        method = 'lazy',
      },
    },
  }

  require('hawtkeys').setup(opts)
end
