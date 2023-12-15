return function ()
local opts = {
  transparent_background = false,
  term_colors = true,
  -- Workaround for using transparent_background with kitty terminal, set false if using another terminal
  kitty = true,
  color_overrides = {
    mocha = {
      mantle = '#1e1e2e',
    },
  },
  highlight_overrides = {
    macchiato = function(macchiato)
      return {
        -- Overrides for the Cokeline
        TabLine = { fg = C.subtext0, bg = C.dim },
        TabLineFill = { bg = C.dim },

        -- Codeium
        CodeiumSuggestion = { link = 'Comment' },

        -- Gitsigns
        GitSignsCurrentLineBlame = { fg = C.overlay1 },

        -- Headlines
        CodeBlock = { bg = C.crust },
        Headline1 = { style = { 'bold' } },
        Headline2 = { style = { 'bold' } },
        Headline3 = { style = { 'bold' } },
        Headline4 = { style = { 'bold' } },
        Headline5 = { style = { 'bold' } },
        Headline6 = { style = { 'bold' } },

        -- Neo-tree
        NeoTreeMessage = { fg = C.overlay0, style = { 'italic' } },

        -- Nvim-Notify
        NotifyBackground = { bg = C.base },

        -- Treesitter-Context
        TreesitterContextBottom = { sp = C.surface2, style = { 'underline' } },
      }
    end,
    mocha = function(mocha)
      return {
        -- Adjust contrast of line numbers
        LineNr = { fg = U.darken(mocha.lavender, 0.50) },
        CursorLineNr = { fg = U.lighten(mocha.lavender, 1.10), style = { 'bold' } },

        -- Overrides for the Cokeline
        TabLine = { fg = C.subtext0, bg = C.dim },
        TabLineFill = { bg = C.dim },

        -- Codeium
        CodeiumSuggestion = { link = 'Comment' },

        -- Gitsigns
        GitSignsCurrentLineBlame = { fg = C.overlay1 },

        -- Headlines
        CodeBlock = { bg = '#181825' },
        Headline1 = { style = { 'bold' } },
        Headline2 = { style = { 'bold' } },
        Headline3 = { style = { 'bold' } },
        Headline4 = { style = { 'bold' } },
        Headline5 = { style = { 'bold' } },
        Headline6 = { style = { 'bold' } },

        -- Neo-tree
        NeoTreeMessage = { fg = C.overlay0, style = { 'italic' } },

        -- Nvim-Notify
        NotifyBackground = { bg = C.base },

        -- Treesitter-Context
        TreesitterContextBottom = { sp = C.surface2, style = { 'underline' } },
      }
    end,
  },
  integrations = {
    alpha = true,
    cmp = true,
    fidget = false,
    gitsigns = true,
    harpoon = true,
    headlines = true,
    illuminate = true,
    lsp_trouble = true,
    mason = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { 'undercurl' },
        hints = { 'undercurl' },
        warnings = { 'undercurl' },
        information = { 'undercurl' },
      },
    },
    neotree = true,
    noice = true,
    notify = true,
    rainbow_delimiters = true,
    semantic_tokens = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    which_key = true,
  },
}

require('catppuccin').setup(opts)
end
