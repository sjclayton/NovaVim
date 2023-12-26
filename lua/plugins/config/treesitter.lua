return function()
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
      'cmake',
      -- 'comment',
      'cpp',
      'css',
      'csv',
      'diff',
      'dockerfile',
      'git_config',
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
      'meson',
      'norg',
      'pug',
      'python',
      'regex',
      'requirements',
      'ron',
      'rst',
      'ruby',
      'rust',
      'scss',
      'svelte',
      'sql',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vue',
      'xml',
      'yaml',
      'zig',
    },
    modules = {},
    sync_install = false,
    -- auto install above language parsers
    auto_install = true,

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },

    -- treesitter-textobjects config
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',

          -- json
          ['ak'] = '@key.outer',
          ['ik'] = '@key.inner',
          ['av'] = '@value.outer',
          ['iv'] = '@value.inner',
        },
        selection_modes = {
          -- ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          -- ['@class.outer'] = '<c-v>', -- blockwise
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>rp'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>rP'] = '@parameter.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
        },
      },
    },
  })

  -- treesitter-context config
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
