return {
  {
    'm4xshen/smartcolumn.nvim',
    event = 'LazyFile',
    -- event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      colorcolumn = '120',
      disabled_filetypes = {
        nil,
        'alpha',
        'checkhealth',
        'help',
        'lazy',
        'markdown',
        'markdown.cody_history',
        'markdown.cody_prompt',
        'mason',
        'noice',
        'text',
        'Trouble',
      },
      -- custom_colorcolumn = { lua = '120', python = '120', go = '120' },
    },
  },
}
