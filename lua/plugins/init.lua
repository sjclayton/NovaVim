local util = require('core.util')
local helper = require('core.helpers')

local conf = function(plugin)
  return require('plugins.config.' .. plugin)
end

return {
  --- General Plugins
  { 'Bekaboo/deadcolumn.nvim', event = { 'LazyFile', 'VeryLazy' }, config = conf('deadcolumn') },
  { 'ThePrimeagen/harpoon', event = 'VeryLazy', config = conf('harpoon') },
  { 'lukas-reineke/headlines.nvim', ft = { 'markdown', 'norg', 'org' }, config = conf('headlines') },
  {
    'shellRaining/hlchunk.nvim',
    keys = {
      {
        '<leader>ub',
        function()
          helper.toggle('Scope line numbers', { enable = 'EnableHLLineNum', disable = 'DisableHLLineNum' })
        end,
        desc = 'Toggle scope line numbers',
        noremap = true,
      },
      {
        '<leader>us',
        function()
          helper.toggle('Scope highlight', { enable = 'EnableHLChunk', disable = 'DisableHLChunk' })
        end,
        desc = 'Toggle scope chunk highlight',
        noremap = true,
      },

      {
        '<leader>ui',
        function()
          helper.toggle('Indention highlights', { enable = 'EnableHLIndent', disable = 'DisableHLIndent' })
        end,
        desc = 'Toggle indention highlights',
        noremap = true,
      },
    },
    config = conf('hlchunk'),
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    keys = {
      {
        '<leader>cp',
        ft = 'markdown',
        '<cmd>MarkdownPreviewToggle<cr>',
        desc = 'Markdown Preview',
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  --- AI
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
    config = conf('codeium'),
  },
  {
    'sourcegraph/sg.nvim',
    -- lazy = false,
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
    config = true,
  },
  --- Coding Related
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
    config = conf('alternatetoggler'),
  },
  { 'numToStr/Comment.nvim', event = 'VeryLazy', config = true },
  { 'lewis6991/gitsigns.nvim', event = 'LazyFile', config = conf('gitsigns') },
  {
    'folke/todo-comments.nvim',
    event = { 'LazyFile' },
    cmd = { 'TodoTrouble', 'TodoTelescope' },
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
    'ThePrimeagen/refactoring.nvim',
    ft = { 'go', 'javascript', 'lua', 'python', 'typescript' },
    dependencies = { 'nvim-treesitter' },
    config = conf('refactoring'),
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
    config = conf('illuminate'),
  },
  --- LSP
  -- General
  { 'kosayoda/nvim-lightbulb', event = 'LazyFile', opts = { autocmd = { enabled = true } } },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = {
      { '<leader>cm', '<CMD>Mason<cr>', desc = 'Open Mason' },
    },
    build = ':MasonUpdate',
    opts = {
      ui = {
        border = 'rounded',
        height = 0.80,
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = false,
    cmd = { 'MasonToolsClean', 'MasonToolsInstall', 'MasonToolsUpdate' },
    dependencies = 'williamboman/mason.nvim',
    config = conf('masontools'),
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'LazyFile' },
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      { 'folke/neodev.nvim', opts = {} },
    },
    config = conf('lsp'),
  },
  -- Completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Completion Sources
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      -- Snippets
      {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
      },
      -- Extensions
      'onsails/lspkind.nvim',
    },
    config = conf('cmp'),
  },
  -- Formatting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        desc = 'Format buffer',
      },
    },
    config = conf('format'),
  },
  -- Linting
  { 'mfussenegger/nvim-lint', event = 'LazyFile', config = conf('lint') },
  --- Language Specific
  {
    'olexsmir/gopher.nvim',
    ft = { 'go', 'gomod' },
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
  },
  --- Treesitter
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
    config = conf('treesitter'),
  },
  --- UI
  {
    'stevearc/dressing.nvim',
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },
  { 'j-hui/fidget.nvim', tag = 'v1.0.0', event = 'LspAttach', config = conf('fidget') },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      -- 'nvim-telescope/telescope.nvim', -- Switch filetype and git branches
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = ' '
      else
        vim.o.laststatus = 0
      end
    end,
    config = conf('lualine'),
  },
  { 'willothy/nvim-cokeline', event = 'LazyFile', config = conf('cokeline') },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    config = conf('noice'),
  },
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
    config = conf('notify'),
  },
  { 'folke/zen-mode.nvim', cmd = 'ZenMode', config = conf('zenmode') },
  --- Colorschemes
  {
    'catppuccin/nvim',
    event = 'User ColorSchemeLoad',
    priority = 1000,
    name = 'catppuccin',
    config = conf('catppuccin'),
  },
  {
    'rose-pine/neovim',
    event = 'User ColorSchemeLoad',
    priority = 1000,
    name = 'rose-pine',
    config = conf('rosepine'),
  },
  --- Utils
  {
    'echasnovski/mini.bufremove',
    version = false,
    keys = {
      {
        '<leader>bd',
        function()
          local bd = require('mini.bufremove').delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = 'Delete Buffer',
      },
      -- stylua: ignore
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
    config = true,
  },
  {
    'JManch/nomodoro',
    keys = {
      { '<leader>nw', '<cmd>NomoWork<cr>', desc = 'Nomo - Start Work' },
      { '<leader>nb', '<cmd>NomoBreak<cr>', desc = 'Nomo - Start Break' },
      { '<leader>ns', '<cmd>NomoStop<cr>', desc = 'Nomo - Stop Timer' },
    },
    config = conf('nomodoro'),
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    keys = {
      {
        '<leader>fT',
        function()
          require('neo-tree.command').execute({ toggle = true, dir = util.get_root() })
        end,
        desc = 'File tree (root dir)',
      },
      {
        '<leader>ft',
        function()
          require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = 'File tree (cwd)',
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end
    end,
    config = conf('neotree'),
  },
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    -- cmd = 'Telescope',
    dependencies = {
      'nvim-telescope/telescope-frecency.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'debugloop/telescope-undo.nvim',
    },
    keys = {
      -- General
      { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch buffer' },
      { '<leader>/', util.telescope('live_grep'), desc = 'Grep (root dir)' },
      -- Files
      { '<leader>fF', util.telescope('files'), desc = 'Find files (root dir)' },
      { '<leader>ff', util.telescope('files', { cwd = vim.loop.cwd() }), desc = 'Find files (cwd)' },
      { '<leader>fR', '<cmd>Telescope frecency<cr>', desc = 'Recent files' },
      { '<leader>fr', '<cmd>Telescope frecency workspace=CWD<cr>', desc = 'Recent files (cwd)' },
      -- search
      { '<leader>t"', '<cmd>Telescope registers<cr>', desc = 'Registers' },
      { '<leader>tk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
      { '<leader>tu', '<cmd>Telescope undo<cr>', desc = 'Undo history' },
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
    config = conf('telescope'),
  },
  { 'wakatime/vim-wakatime', event = 'InsertEnter' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'folke/which-key.nvim', event = 'VeryLazy', config = conf('whichkey') },
}
