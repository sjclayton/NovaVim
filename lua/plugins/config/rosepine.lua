return function()
  local opts = {
    dim_inactive_windows = true,
    extend_background_behind_borders = true,
    enable = {
      legacy_highlights = true,
    },
    styles = {
      transparency = false,
    },
    highlight_groups = {
      ['@namespace'] = { link = 'Include' },
      FloatTitle = { link = 'NormalFloat' },
      Search = { bg = 'rose' },
      WinSeparator = { fg = 'muted' },
      Winbar = { link = 'Normal' },
      WinbarNC = { link = 'NormalNC' },

      -- Cmp
      CmpPmenu = { link = 'NormalFloat' },

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

      -- Nvim-Lspconfig
      LspInfoBorder = { link = 'FloatBorder' },

      -- Neotest
      NeotestIndent = { fg = 'subtle' },
      NeotestExpandMarker = { fg = 'subtle' },

      -- Neo-Tree
      NeoTreeDirectoryIcon = { fg = 'foam' },
      NeoTreeDimText = { fg = 'muted' },
      NeoTreeMessage = { fg = 'muted', italic = true },
      NeoTreeWinSeparator = { fg = 'muted' },

      -- Nvim-Notify
      NotifyBackground = { bg = 'base' },

      -- Outline.nvim
      OutlineCurrent = { link = 'String' },
      OutlineGuides = { link = 'WinSeparator' },
      OutlineFoldMarker = { link = 'Normal' },
      OutlineDetails = { link = 'Comment' },

      -- Which-Key
      WhichKeyBorder = { link = 'FloatBorder' },

      -- Treesitter-Context
      TreesitterContextBottom = { sp = 'muted', underline = true },
    },
  }

  require('rose-pine').setup(opts)
end
