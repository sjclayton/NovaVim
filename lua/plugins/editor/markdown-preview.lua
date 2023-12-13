return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  keys = {
    {
      '<leader>cp',
      ft = 'markdown',
      '<cmd>MarkdownPreviewToggle<cr>',
      desc = 'Peek (Markdown Preview)',
    },
  },
  config = function()
    vim.cmd([[do FileType]])
  end,
}
