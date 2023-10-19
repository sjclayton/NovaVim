return {
  {
    'folke/zen-mode.nvim',
    keys = {
      { '<leader>uZ', '<cmd>ZenMode<cr>', desc = 'Toggle zen mode' },
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      zindex = 20,
      window = {
        backdrop = 1,
        width = 0.75,
      },
      plugins = {
        options = {
          laststatus = 0,
        },
        gitsigns = { enabled = true },
        tmux = { enabled = true },
      },
    },
  },
}
