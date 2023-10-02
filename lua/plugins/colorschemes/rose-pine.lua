return {
  {
    'rose-pine/neovim',
    priority = 1000,
    event = 'User ColorSchemeLoad',
    name = 'rose-pine',
    config = function()
      Colorscheme = 'rose-pine'
      require('rose-pine').setup({
        disable_background = true,
        dim_nc_background = false,
        highlight_groups = {
          -- Alpha Dashboard
          AlphaHeaderLabel = { fg = 'gold' },

          -- Cmp
          CmpPmenu = { bg = 'base' },

          -- GitSigns
          -- HACK: Override background color because it doesn't get set properly by the plugin
          -- itself when the transparent background is enabled.
          GitSignsAdd = { bg = '' },
          GitSignsChange = { bg = '' },
          GitSignsDelete = { bg = '' },
          GitSignsUntracked = { bg = '' },

          -- Harpoon
          HarpoonBorder = { fg = 'muted', bg = 'surface' },
          HarpoonWindow = { fg = 'text', bg = 'surface' },
          HarpoonCurrentFile = { fg = 'rose' },

          -- Noice
          NoicePopup = { bg = 'base' },
          NoiceMini = { bg = 'surface' },

          -- Nvim-Notify
          NotifyBackground = { bg = 'base' },
        },
      })
    end,
  },
}
