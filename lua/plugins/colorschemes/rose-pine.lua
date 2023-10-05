return {
  {
    'rose-pine/neovim',
    priority = 1000,
    event = 'User ColorSchemeLoad',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        dim_nc_background = false,
        highlight_groups = {
          -- Alpha Dashboard
          AlphaHeaderLabel = { fg = 'gold' },

          -- Bufferline
          BufferLineBackground = { fg = 'muted', italic = true },
          BufferLineBufferSelected = { fg = 'pine', bold = true },
          BufferLinePick = { fg = 'iris' },
          BufferLinePickSelected = { fg = 'iris' },
          BufferLinePickVisible = { fg = 'iris' },

          -- Cmp
          CmpPmenu = { bg = 'base' },

          -- Fidget
          FidgetTitle = { fg = 'pine' },

          -- GitSigns
          -- HACK: Override background color because it doesn't get set properly by the plugin
          -- itself when the transparent background is enabled.
          GitSignsAdd = { bg = '' },
          GitSignsChange = { bg = '' },
          GitSignsDelete = { bg = '' },
          GitSignsUntracked = { bg = '' },

          -- Harpoon
          HarpoonBorder = { fg = 'muted', bg = 'surface' },
          HarpoonCurrentFile = { fg = 'rose' },
          HarpoonWindow = { fg = 'text', bg = 'surface' },

          -- Headlines
          Dash = { fg = 'overlay' },
          Quote = { link = '@text.strong' },
          CodeBlock = { bg = 'highlight_low' },
          Headline = { link = 'Headline1' },
          Headline1 = { bg = 'overlay', fg = 'love' },
          Headline2 = { bg = 'overlay', fg = 'rose' },
          Headline3 = { bg = 'overlay', fg = 'gold' },
          Headline4 = { bg = 'overlay', fg = 'pine' },
          Headline5 = { bg = 'overlay', fg = 'foam' },
          Headline6 = { bg = 'overlay', fg = 'iris' },

          -- Noice
          NoicePopup = { bg = 'base' },
          NoiceMini = { bg = 'surface' },

          -- Nvim-Notify
          NotifyBackground = { bg = 'base' },

          -- Which-key
          WhichKeyBorder = { link = 'FloatBorder' },
          WhichKeyFloat = { link = 'NormalFloat' },
        },
      })
    end,
  },
}
