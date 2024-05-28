return function()
  local C = require('catppuccin.palettes').get_palette()
  local U = require('catppuccin.utils.colors')

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
          WinSeparator = { fg = C.dim and C.surface2 or C.crust },

          -- Codeium
          CodeiumSuggestion = { link = 'Comment' },

          -- Gitsigns
          GitSignsCurrentLineBlame = { fg = C.overlay0 },

          -- Harpoon
          HarpoonCurrentFile = { fg = C.green },

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

          -- Outline.nvim
          OutlineCurrent = { link = 'String' },
          OutlineGuides = { link = 'Comment' },
          OutlineFoldMarker = { link = 'Normal' },
          OutlineDetails = { link = 'Comment' },

          -- Treesitter-Context
          TreesitterContextLineNumber = { link = 'LineNr' },
          TreesitterContextBottom = { sp = C.surface2, style = { 'underline' } },
        }
      end,
      mocha = function(mocha)
        return {
          WinSeparator = { fg = C.dim and C.surface2 or C.crust },

          -- Adjust contrast of line numbers
          LineNr = { fg = U.darken(mocha.lavender, 0.50) },
          CursorLineNr = { fg = U.lighten(mocha.lavender, 1.10), style = { 'bold' } },

          -- Codeium
          CodeiumSuggestion = { link = 'Comment' },

          -- Gitsigns
          GitSignsCurrentLineBlame = { fg = C.overlay0 },

          -- Harpoon
          HarpoonCurrentFile = { fg = C.green },

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

          -- Outline.nvim
          OutlineCurrent = { link = 'String' },
          OutlineGuides = { link = 'Comment' },
          OutlineFoldMarker = { link = 'Normal' },
          OutlineDetails = { link = 'Comment' },

          -- Treesitter-Context
          TreesitterContextLineNumber = { link = 'CursorLineNr' },
          TreesitterContextBottom = { sp = C.surface2, style = { 'underline' } },
        }
      end,
    },
    integrations = {
      cmp = true,
      dap = true,
      dap_ui = true,
      fidget = false,
      gitsigns = true,
      harpoon = true,
      headlines = true,
      hop = true,
      illuminate = true,
      lsp_trouble = true,
      mason = true,
      native_lsp = {
        enabled = true,
        -- virtual_text = {
        --   errors = { 'italic' },
        --   hints = { 'italic' },
        --   warnings = { 'italic' },
        --   information = { 'italic' },
        -- },
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
        inlay_hints = {
          background = true,
        },
      },
      neogit = true,
      neotest = true,
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
