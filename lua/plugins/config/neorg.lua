return function()
  local opts = {
    load = {
      ['core.defaults'] = {},
      ['core.completion'] = { config = { engine = 'nvim-cmp', name = '[Norg]' } },
      ['core.integrations.nvim-cmp'] = {},
      ['core.highlights'] = {
        config = {
          highlights = {
            headings = {
              ['1'] = { prefix = '+@macro', title = '+@macro' },
              ['2'] = { prefix = '+@label', title = '+@label' },
              ['3'] = { prefix = '+@boolean', title = '+@boolean' },
              ['4'] = { prefix = '+@string', title = '+@string' },
              ['5'] = { prefix = '+@conditional', title = '+@conditional' },
              ['6'] = { prefix = '+Error', title = '+Error' },
            },
          },
        },
      },
      ['core.tempus'] = {},
      ['core.ui.calendar'] = {},
      ['core.journal'] = {
        config = {
          strategy = 'flat',
          workspace = 'Notes',
        },
      },
      ['core.concealer'] = {
        config = {
          folds = false,
          icons = { code_block = { conceal = true } },
          icon_preset = 'diamond',
        },
      },
      ['core.keybinds'] = {
        -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
        config = {
          default_keybinds = true,
          neorg_leader = '<leader>.',
        },
      },
      ['core.dirman'] = {
        config = {
          workspaces = {
            Notes = '~/Notes',
            Projects = '~/Notes/Projects',
            Learning = '~/Notes/Learning',
          },
          default_workspace = 'Notes',
        },
      },
    },
  }
  require('neorg').setup(opts)
end
