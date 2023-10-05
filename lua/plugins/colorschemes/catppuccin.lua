return {
  {
    'catppuccin/nvim',
    priority = 1000,
    event = 'User ColorSchemeLoad',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        transparent_background = true,
        term_colors = true,
        -- Workaround for using transparent_background with kitty terminal, set false if using another terminal
        kitty = true,
        color_overrides = {
          mocha = {
            mantle = '#1e1e2e',
          },
        },
        highlight_overrides = {
          mocha = function(mocha)
            return {
              -- Adjust contrast of line numbers
              LineNr = { fg = U.darken(mocha.lavender, 0.50) },
              CursorLineNr = { fg = U.lighten(mocha.lavender, 1.10), style = { 'bold' } },

              -- Bufferline
              BufferLineBackground = { fg = C.overlay0, style = { 'italic' } },
              BufferLineBufferSelected = { fg = C.lavender, style = { 'bold' } },
              BufferLinePick = { fg = C.maroon },
              BufferLinePickSelected = { fg = C.maroon },
              BufferLinePickVisible = { fg = C.maroon },

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

              -- Nvim-Notify
              NotifyBackground = { bg = C.base },
            }
          end,
        },
        integrations = {
          alpha = true,
          cmp = true,
          fidget = false,
          -- flash = true,
          gitsigns = true,
          harpoon = true,
          headlines = true,
          illuminate = true,
          -- lsp_trouble = true,
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
          navic = { enabled = true, custom_bg = 'NONE' },
          -- neotest = true,
          noice = true,
          notify = true,
          -- neotree = true,
          rainbow_delimiters = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      })
    end,
  },
}
