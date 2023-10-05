return {
  {
    'mcauley-penney/tidy.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      filetype_exclude = { 'markdown', 'diff' },
    },
  },
}
