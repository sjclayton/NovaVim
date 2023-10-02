return {
  {
    'mcauley-penney/tidy.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      filetype_exclude = { 'markdown', 'diff' },
    },
  },
}
