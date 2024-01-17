return function()
  local opts = {
    dim_inactive_windows = true,
    extend_background_behind_borders = true,
    styles = {
      transparency = false,
    },
    highlight_groups = {
      FloatTitle = { link = 'NormalFloat' },
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

      -- Neotest
      NeotestPassed = { fg = 'green' },
      NeotestFailed = { fg = 'love' },
      NeotestRunning = { fg = 'gold' },
      NeotestSkipped = { fg = 'foam' },
      NeotestTest = { fg = 'text' },
      NeotestNamespace = { fg = 'iris' },
      NeotestFocused = { bold = true, underline = true },
      NeotestFile = { fg = 'foam' },
      NeotestDir = { fg = 'foam' },
      NeotestIndent = { fg = 'muted' },
      NeotestExpandMarker = { fg = 'muted' },
      NeotestAdapterName = { fg = 'rose' },
      NeotestWinSelect = { fg = 'foam', bold = true },
      NeotestMarked = { fg = 'gold', bold = true },
      NeotestTarget = { fg = 'love' },
      NeotestUnknown = { fg = 'muted' },

      -- Neo-tree
      NeoTreeDirectoryIcon = { fg = 'foam' },
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
