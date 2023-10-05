return {
  {
    'folke/zen-mode.nvim',
    keys = {
      {
        '<leader>uZ',
        ':ZenMode<CR>',
        desc = 'Toggle zen mode',
        noremap = true,
      },
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
