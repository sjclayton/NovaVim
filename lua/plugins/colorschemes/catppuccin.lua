return {
  {
    'catppuccin/nvim',
    priority = 1000,
    event = 'User ColorSchemeLoad',
    name = 'catppuccin',
    config = function()
      Colorscheme = 'catppuccin-mocha'

      require('catppuccin').setup({
        transparent_background = true,
        term_colors = true,
        kitty = true, -- Workaround for using transparent_background with kitty terminal, set false if using another terminal
        color_overrides = {},
        highlight_overrides = {
          mocha = function(mocha)
            return {
              -- Adjust contrast of line numbers
              LineNr = { fg = U.darken(mocha.lavender, 0.50) },
              CursorLineNr = { fg = U.lighten(mocha.lavender, 1.10), style = { 'bold' } },

              -- Codeium
              CodeiumSuggestion = { link = 'Comment' },

              -- Nvim-Notify
              NotifyBackground = { bg = C.base },
            }
          end,
        },
        integrations = {
          alpha = true,
          barbar = true,
          cmp = true,
          -- flash = true,
          gitsigns = true,
          harpoon = true,
          -- illuminate = true,
          -- lsp_trouble = true,
          mason = true,
          -- mini = true,
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
