return {
  {
    'rose-pine/neovim',
    priority = 1000,
    event = 'User ColorSchemeLoad',
    name = 'rose-pine',
    opts = {
      disable_background = true,
      highlight_groups = {
        -- Alpha Dashboard
        AlphaHeaderLabel = { fg = 'gold' },

        -- Harpoon
        HarpoonBorder = { fg = 'muted', bg = 'surface' },
        HarpoonWindow = { fg = 'text', bg = 'surface' },
        HarpoonCurrentFile = { fg = 'rose' },

        -- Nvim-Notify
        NotifyBackground = { bg = 'base' },
      },
    },
  },
}
