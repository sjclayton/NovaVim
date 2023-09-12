return {
  {
    'm4xshen/smartcolumn.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      colorcolumn = { '80', '100' },
      disabled_filetypes = { 'alpha', 'help', 'lazy', 'markdown', 'mason', 'text' },
      custom_colorcolumn = { lua = "120" },
    },
  },
}
