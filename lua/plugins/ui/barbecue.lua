return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons', -- optional dependency
  },
  config = function()
    require('barbecue').setup({
      create_autocmd = false, -- prevent barbecue from updating itself automatically
      show_dirname = false,
      show_basename = false,
      show_modified = false,
      kinds = require('core.icons').kinds,
      theme = {
        separator = { fg = '#737aa2' },
      },
    })

    vim.api.nvim_create_autocmd({
      'WinScrolled', -- or WinResized on NVIM-v0.9 and higher
      'BufWinEnter',
      'CursorHold',
      'InsertLeave',
      'LspAttach',

      -- include this if you have set `show_modified` to `true`
      -- 'BufModifiedSet',
    }, {
      group = vim.api.nvim_create_augroup('barbecue.updater', {}),
      callback = function()
        require('barbecue.ui').update()
      end,
    })
  end,
}
