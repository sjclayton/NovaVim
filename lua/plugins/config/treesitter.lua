return function ()
local treesitter = require('nvim-treesitter.configs')

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
    disable = { 'zig' },
  },
  -- disable indentation
  indent = { enable = false },
  -- ensure these language parsers are installed
  ignore_install = {},
  ensure_installed = {
    'bash',
    'c',
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
    'ron',
    'rst',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'xml',
    'yaml',
    'zig',
  },
  modules = {},
  sync_install = false,
  -- auto install above language parsers
  auto_install = true,
})

-- TS-context config
local context = require('treesitter-context')

context.setup({
  max_lines = 3,
  zindex = 25,
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
    -- lua = 'rainbow-blocks',
  },
  highlight = {
    -- 'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}
end
