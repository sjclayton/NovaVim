local util = require('core.util')
local helper = require('core.helpers')

return {
  -- General Plugins
  { 'Bekaboo/deadcolumn.nvim', event = { 'LazyFile', 'VeryLazy' }, config = require('plugins.config.deadcolumn') },
  -- AI
  {
    'Exafunction/codeium.vim',
    keys = {
      {
        '<leader>cC',
        function()
          helper.toggle('Codeium', { enable = 'CodeiumEnable', disable = 'CodeiumDisable' })
        end,
        desc = 'Toggle Codeium completion',
        noremap = true,
      },
    },
    config = require('plugins.config.codeium'),
  },
  {
    'sourcegraph/sg.nvim',
    name = 'cody',
    keys = {
      {
        '<leader>cc',
        function()
          vim.cmd(':CodyToggle')
          vim.cmd(':vertical resize +25N')
        end,
        desc = 'Toggle Cody chat',
        noremap = true,
      },
      {
        '<leader>cq',
        function()
          vim.ui.input({ prompt = 'What is your question:' }, function(input)
            if input ~= nil or not '' then
              vim.cmd("'<,'>:CodyAsk " .. input)
              vim.cmd(':vertical resize +25N')
            end
          end)
        end,
        mode = 'v',
        desc = 'Ask Cody about the current selection',
        noremap = true,
      },
    },
  },
  -- Coding Related
  {
    'rmagatti/alternate-toggler',
    keys = {
      {
        '<CR>',
        "<cmd>lua require('alternate-toggler').toggleAlternate()<cr>",
        desc = 'Toggle alternate',
        noremap = true,
      },
    },
    config = require('plugins.config.alternatetoggler'),
  },
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'LazyFile' },
    keys = {
      -- stylua: ignore start
      { ']t', function() require('todo-comments').jump_next() end, desc = 'Next todo comment', },
      { '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous todo comment', },
      -- stylua: ignore end
      { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo (Trouble)' },
      { '<leader>xT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
      { '<leader>tt', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
      { '<leader>tT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
    },
    config = true,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xL', '<cmd>TroubleToggle loclist<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>TroubleToggle quickfix<cr>', desc = 'Quickfix List (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next trouble/quickfix item',
      },
    },
  },
  {
    'RRethy/vim-illuminate',
    event = 'LazyFile',
    keys = {
      { ']]', desc = 'Next Reference' },
      { '[[', desc = 'Prev Reference' },
    },
    config = require('plugins.config.illuminate'),
  },
  -- Completion
  -- LSP
  -- Language Specific
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'LazyFile', 'VeryLazy' },
    version = false,
    dependencies = { 'HiPhish/rainbow-delimiters.nvim', 'nvim-treesitter/nvim-treesitter-context' },
    build = ':TSUpdate',
    init = function(plugin)
      require('lazy.core.loader').add_to_rtp(plugin)
      require('nvim-treesitter.query_predicates')
    end,
    config = require('plugins.config.treesitter'),
  },
  -- UI
  {
    'rcarriga/nvim-notify',
    init = function()
      -- If noice is not enabled, Load  notify on VeryLazy
      if not util.has('noice.nvim') then
        util.on_very_lazy(function()
          vim.notify = require('notify')
        end)
      end
    end,
    config = require('plugins.config.notify'),
  },
  -- Colorschemes
  {
    'catppuccin/nvim',
    priority = 1000,
    event = 'User ColorSchemeLoad',
    name = 'catppuccin',
    config = require('plugins.config.catppuccin'),
  },
  {
    'rose-pine/neovim',
    priority = 1000,
    event = 'User ColorSchemeLoad',
    name = 'rose-pine',
    config = require('plugins.config.rose-pine'),
  },
  -- Utils
  { 'nvim-lua/plenary.nvim' },
  { 'folke/which-key.nvim', event = 'VeryLazy', config = require('plugins.config.whichkey') },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = { { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
    keys = {
      -- General
      { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch buffer' },
      { '<leader>/', util.telescope('live_grep'), desc = 'Grep (root dir)' },
      -- Files
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
      { '<leader>ff', util.telescope('files'), desc = 'Find files (root dir)' },
      { '<leader>fF', util.telescope('files', { cwd = vim.loop.cwd() }), desc = 'Find files (cwd)' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
      { '<leader>fR', util.telescope('oldfiles', { cwd = vim.loop.cwd() }), desc = 'Recent files (cwd)' },
      -- search
      { '<leader>t"', '<cmd>Telescope registers<cr>', desc = 'Registers' },
      { '<leader>tk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
      {
        '<leader>uC',
        function()
          vim.api.nvim_exec_autocmds('User', { pattern = 'ColorSchemeLoad' })
          vim.cmd('Telescope colorscheme')
        end,
        desc = 'Switch colorscheme',
        noremap = true,
      },
    },
    config = require('plugins.config.telescope'),
  },
}
