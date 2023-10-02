return {
  {
    'shellRaining/hlchunk.nvim',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        '<leader>uc',
        function()
          require('core.helpers').toggle('HLChunkLine', { enable = 'EnableHLLineNum', disable = 'DisableHLLineNum' })
        end,
        desc = 'Toggle Chunk Line Numbers',
        noremap = true,
      },
      {
        '<leader>rh',
        function()
          vim.cmd('Lazy reload hlchunk.nvim')
        end,
        desc = 'Reload HL Chunk',
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
          -- details about support_filetypes and exclude_filetypes in https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
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
      vim.cmd(':DisableHLLineNum')
    end,
  },
}
