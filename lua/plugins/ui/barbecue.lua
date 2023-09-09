return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons', -- optional dependency
  },
  opts = {
    -- configurations go here
    show_dirname = false,
    show_basename = false,
    show_modified = false,
    kinds = require('core.icons').kinds,
  },
}
