return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = 'HiPhish/rainbow-delimiters.nvim',
    build = ':TSUpdate',
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require('nvim-treesitter.configs')

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- disable indentation
        indent = { enable = false },
        -- ensure these language parsers are installed
        ensure_installed = {
          'bash',
          'c',
          'comment',
          'css',
          'csv',
          'diff',
          'dockerfile',
          'gitcommit',
          'gitignore',
          'go',
          'gomod',
          'gosum',
          'gowork',
          'html',
          'javascript',
          'json',
          'jsonc',
          'lua',
          'luadoc',
          'make',
          'markdown',
          'markdown_inline',
          'python',
          'regex',
          'rst',
          'rust',
          'scss',
          'toml',
          'tsx',
          'typescript',
          'vim',
          'xml',
          'yaml',
        },
        -- auto install above language parsers
        auto_install = true,
      })

      -- Rainbow delimiters config
      local rainbow_delimiters = require('rainbow-delimiters')

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
          'RainbowDelimiterOrange',
        },
      }
    end,
  },
}
