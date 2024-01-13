return function()
  local opts = {
    dim_inactive_windows = true,
    extend_background_behind_borders = true,
    styles = {
      transparency = false,
    },
    highlight_groups = {
      Search = { bg = 'rose' },
      WinSeparator = { fg = 'muted' },

      -- Cmp
      CmpPmenu = { link = 'NormalFloat' },

      -- Cokeline
      TabLineFill = { fg = 'surface', bg = 'base' },

      -- Harpoon
      HarpoonBorder = { link = 'FloatBorder' },
      HarpoonCurrentFile = { fg = 'rose' },
      HarpoonWindow = { link = 'NormalFloat' },

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

      -- Neo-tree
      NeoTreeDimText = { fg = 'muted' },
      NeoTreeMessage = { fg = 'muted', italic = true },
      NeoTreeWinSeparator = { fg = 'muted' },

      -- Nvim-Notify
      NotifyBackground = { bg = 'base' },

      -- Which-key
      WhichKeyBorder = { link = 'FloatBorder' },

      -- Treesitter-Context
      TreesitterContextBottom = { sp = 'muted', underline = true },
    },
  }

  require('rose-pine').setup(opts)
end
