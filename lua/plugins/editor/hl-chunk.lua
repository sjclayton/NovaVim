local toggle = require('core.helpers').toggle

return {
  'shellRaining/hlchunk.nvim',
  event = 'LazyFile',
  -- event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    {
      '<leader>ub',
      function()
        toggle('Scope line numbers', { enable = 'EnableHLLineNum', disable = 'DisableHLLineNum' })
      end,
      desc = 'Toggle scope line numbers',
      noremap = true,
    },
    {
      '<leader>us',
      function()
        toggle('Scope highlight', { enable = 'DisableHLChunk', disable = 'EnableHLChunk' })
      end,
      desc = 'Toggle scope highlight',
      noremap = true,
    },

    {
      '<leader>ui',
      function()
        toggle('Indention highlights', { enable = 'EnableHLIndent', disable = 'DisableHLIndent' })
      end,
      desc = 'Toggle indention highlights',
      noremap = true,
    },
  },
  config = function()
    --- @diagnostic disable-next-line : missing-fields
    require('hlchunk').setup({
      chunk = {
        enable = true,
        notify = false,
        use_treesitter = true,
        -- details about support_filetypes and exclude_filetypes in
        -- https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
        support_filetypes = {},
        exclude_filetypes = {},
        chars = {
          horizontal_line = '─',
          vertical_line = '│',
          left_top = '╭',
          left_bottom = '╰',
          right_arrow = '>',
        },
        style = {
          vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Function')), 'fg', 'gui'),
        },
        textobject = '',
        max_file_size = 1024 * 1024,
        error_sign = false,
      },

      indent = {
        enable = true,
        notify = false,
        use_treesitter = false,
        chars = {
          '│',
        },
        style = {
          vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Whitespace')), 'fg', 'gui'),
        },
      },

      line_num = {
        enable = true,
        notify = false,
        use_treesitter = true,
        style = {
          vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('CursorLineNr')), 'fg', 'gui'),
        },
      },

      blank = {
        enable = false,
        notify = false,
        use_treesitter = false,
        chars = {
          '·',
          -- '․.·',
        },
        style = {
          vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Whitespace')), 'fg', 'gui'),
        },
      },
    })
    vim.cmd('DisableHLIndent')
    vim.cmd('DisableHLLineNum')

    -- HACK: Workaround to fix scope highlights not being properly set when colorscheme is changed.
    vim.api.nvim_create_augroup('reload_hlchunk', { clear = true })
    vim.api.nvim_create_autocmd('Colorscheme', {
      group = 'reload_hlchunk',
      callback = function()
        vim.cmd('Lazy reload hlchunk.nvim')
      end,
    })
  end,
}
