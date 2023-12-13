return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  -- event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {},
  config = function()
    -- import comment plugin safely
    local comment = require('Comment')

    -- enable comment
    comment.setup({})
  end,
}
