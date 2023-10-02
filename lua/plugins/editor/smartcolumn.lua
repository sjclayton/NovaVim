return {
  {
    'm4xshen/smartcolumn.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      colorcolumn = '100',
      disabled_filetypes = {
        nil,
        'alpha',
        'help',
        'lazy',
        'markdown',
        'markdown.cody_history',
        'markdown.cody_prompt',
        'mason',
        'noice',
        'text',
      },
      custom_colorcolumn = { lua = '120', python = '120' },
    },
  },
}
