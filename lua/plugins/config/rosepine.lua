return function()
  local opts = {
    dim_inactive_windows = true,
    extend_background_behind_borders = true,
    styles = {
      transparency = false,
    },
    groups = {
      -- panel = 'base',
    },
    highlight_groups = {
      WinSeparator = { fg = 'muted' },

      -- Cmp
      CmpPmenu = { bg = 'surface' },

      -- Cokeline
      TabLineFill = { fg = 'surface', bg = 'base' },

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

      -- Neo-tree
      NeoTreeDimText = { fg = 'muted' },
      NeoTreeMessage = { fg = 'muted', italic = true },
      NeoTreeWinSeparator = { fg = 'muted' },

      -- Noice
      NoicePopup = { bg = 'base' },
      NoiceMini = { bg = 'surface' },

      -- Nvim-Notify
      NotifyBackground = { bg = 'base' },

      -- Which-key
      WhichKeyBorder = { link = 'FloatBorder' },
      WhichKeyFloat = { link = 'NormalFloat' },

      -- Treesitter-Context
      TreesitterContextBottom = { sp = 'muted', underline = true },
    },
  }

  require('rose-pine').setup(opts)
end
