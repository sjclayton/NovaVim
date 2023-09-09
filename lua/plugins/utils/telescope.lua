return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    branch = '0.1.x',
    cmd = 'Telescope',
    config = function()
      require('telescope').setup({
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })
      -- Essential Telescope extensions
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('notify')
    end,
  },
}
