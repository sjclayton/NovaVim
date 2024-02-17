return function()
  local tele_actions = require('telescope.actions')

  local opts = {
    defaults = {
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          anchor = 'center',
          height = 0.9,
          width = 0.9,
          preview_width = 0.55,
          prompt_position = 'bottom',
        },
      },
      mappings = {
        i = {
          ['<esc>'] = tele_actions.close,
        },
      },
    },
    extensions = {
      frecency = {
        hide_current_buffer = true,
        ignore_patterns = { '*.git/*', '*/tmp/*', 'term://*', '*.obsidian/*' },
        workspaces = {
          ['notes'] = '~/Notes/',
        },
      },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      undo = {
        -- use_delta = false,
        -- side_by_side = true,
        layout_strategy = 'vertical',
        layout_config = {
          preview_height = 0.65,
        },
      },
    },
  }

  require('telescope').setup(opts)

  -- require('telescope').load_extension('fzf')
  require('telescope').load_extension('frecency')
  require('telescope').load_extension('notify')
  require('telescope').load_extension('undo')
end
