local util = require('core.util')
local helper = require('core.helpers')

local conf = function(plugin)
  return require('plugins.config.' .. plugin)
end

local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input('Run with args: ', table.concat(args, ' ')) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], ' ')
  end
  return config
end

return {
  --- General
  { 'Bekaboo/deadcolumn.nvim', event = { 'LazyFile', 'VeryLazy' }, config = conf('deadcolumn') },
  { 'ThePrimeagen/harpoon', event = 'VeryLazy', dependencies = 'nvim-lua/plenary.nvim', config = conf('harpoon') },
  {
    'lukas-reineke/headlines.nvim',
    ft = { 'markdown' },
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = conf('headlines'),
  },
  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {
      keys = 'asdghklqwertyuiopzxcvbnmfj',
    },
    keys = {
      { '<leader>j', '<CMD>HopWord<CR>', desc = 'Hop to any word' },
      { '<leader>k', '<CMD>HopLineStart<CR>', desc = 'Hop to start of line' },
      { '<leader>i', '<CMD>HopWordCurrentLine<CR>', desc = 'Hop to word (current line)' },
    },
  },
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
        '<leader>uB',
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
    '3rd/image.nvim',
    ft = { 'markdown' },
    opts = {
      only_render_image_at_cursor = true,
      window_overlap_clear_enabled = true,
      tmux_show_only_in_active_window = true,
    },
    config = true,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    keys = {
      { '<leader>cp', ft = 'markdown', '<CMD>MarkdownPreviewToggle<CR>', desc = 'Markdown Preview' },
    },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    'epwalsh/obsidian.nvim',
    event = {
      'BufReadPre ' .. vim.fn.expand('~') .. '/Notes/**.md',
      'BufNewFile ' .. vim.fn.expand('~') .. '/Notes/**.md',
    },
    cmd = {
      'ObsidianOpen',
      'ObsidianNew',
      'ObsidianQuickSwitch',
      'ObsidianFollowLink',
      'ObsidianBacklinks',
      'ObsidianToday',
      'ObsidianYesterday',
      'ObsidianTemplate',
      'ObsidianSearch',
      'ObsidianLink',
      'ObsidianLinkNew',
    },
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = conf('obsidian'),
  },
  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood',
  },

  --- AI
  {
    'Exafunction/codeium.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp' },
    config = true,
  },
  {
    'David-Kunz/gen.nvim',
    keys = {
      { '<leader>gn', ':Gen<CR>', desc = 'Select AI prompt', mode = { 'n', 'v' } },
    },
    config = conf('gen'),
  },

  --- Coding
  {
    'rmagatti/alternate-toggler',
    keys = {
      {
        '<leader>v',
        "<CMD>lua require('alternate-toggler').toggleAlternate()<CR>",
        desc = 'Alternate value',
        noremap = true,
      },
    },
    config = conf('alternatetoggler'),
  },
  { 'numToStr/Comment.nvim', event = 'VeryLazy', config = true },
  { 'lewis6991/gitsigns.nvim', event = 'LazyFile', config = conf('gitsigns') },
  { 'echasnovski/mini.ai', event = 'VeryLazy', version = false, config = conf('mini-ai') },
  { 'echasnovski/mini.pairs', event = 'VeryLazy', version = false, config = true },
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {
      silent = true,
      mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`
      },
    },
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require('lazy.core.config').spec.plugins['mini.surround']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local mappings = {
        { opts.mappings.add, desc = 'Add surrounding', mode = { 'n', 'v' } },
        { opts.mappings.delete, desc = 'Delete surrounding' },
        { opts.mappings.find, desc = 'Find right surrounding' },
        { opts.mappings.find_left, desc = 'Find left surrounding' },
        { opts.mappings.highlight, desc = 'Highlight surrounding' },
        { opts.mappings.replace, desc = 'Replace surrounding' },
        { opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    config = true,
  },
  {
    'luckasRanarison/nvim-devdocs',
    opts = {
      ensure_installed = { 'go', 'rust' },
    },
    keys = {
      { '<leader>cD', '<CMD>DevdocsOpenCurrentFloat<CR>', desc = 'Browse language docs', ft = { 'go', 'rust' } },
    },
    build = ':DevdocsFetch',
  },
  {
    'folke/todo-comments.nvim',
    event = { 'LazyFile' },
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      -- stylua: ignore start
      { ']t', function() require('todo-comments').jump_next() end, desc = 'Next todo comment', },
      { '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous todo comment', },
      -- stylua: ignore end
      { '<leader>xt', '<CMD>TodoTrouble<CR>', desc = 'Todo (Trouble)' },
      { '<leader>xT', '<CMD>TodoTrouble keywords=TODO,FIX,FIXME<CR>', desc = 'Todo/Fix/Fixme (Trouble)' },
      { '<leader>tt', '<CMD>TodoTelescope<CR>', desc = 'Todo' },
      { '<leader>tT', '<CMD>TodoTelescope keywords=TODO,FIX,FIXME<CR>', desc = 'Todo/Fix/Fixme' },
    },
    config = true,
  },
  {
    'ThePrimeagen/refactoring.nvim',
    ft = { 'go', 'javascript', 'lua', 'python', 'typescript' },
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    config = conf('refactoring'),
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { 'sj', '<CMD>TSJJoin<CR>', desc = 'TS join lines' },
      { 'sk', '<CMD>TSJSplit<CR>', desc = 'TS split lines' },
    },
  },
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = { use_diagnostic_signs = true },
    keys = {
      { '<leader>xx', '<CMD>TroubleToggle document_diagnostics<CR>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xX', '<CMD>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xL', '<CMD>TroubleToggle loclist<CR>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<CMD>TroubleToggle quickfix<CR>', desc = 'Quickfix List (Trouble)' },
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
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        border = 'rounded',
        height = 0.80,
      },
    },
    keys = {
      { '<leader>um', '<CMD>Mason<CR>', desc = 'Open Mason' },
    },
    build = ':MasonUpdate',
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
    event = { 'LazyFile' },
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
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
      'Exafunction/codeium.nvim',
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
  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        opts = {},
        -- stylua: ignore
        keys = {
          { '<leader>du', function() require('dapui').toggle() end, desc = 'Toggle DAP UI' },
          { '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = { 'n', 'v' } },
        },
        config = function(_, opts)
          local dap = require('dap')
          local dapui = require('dapui')
          dapui.setup(opts)
          -- stylua: ignore start
          dap.listeners.after.event_initialized['dapui_config'] = dapui.open
          dap.listeners.before.event_terminated['dapui_config'] = dapui.close
          dap.listeners.before.event_exited['dapui_config'] = dapui.close
          -- stylua: ignore end
        end,
      },
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    },
    -- stylua: ignore
    keys = {
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint condition' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Run / Continue' },
      { '<leader>da', function() require('dap').continue({ before = get_args }) end, desc = 'Run with args' },
      { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to cursor' },
      { '<leader>dg', function() require('dap').goto_() end, desc = 'Go to line (no execute)' },
      { '<leader>dh', function() require('dap').step_back() end, desc = 'Step back' },
      { '<leader>dj', function() require('dap').step_into() end, desc = 'Step into' },
      { '<leader>dk', function() require('dap').step_out() end, desc = 'Step out' },
      { '<leader>dl', function() require('dap').step_over() end, desc = 'Step over' },
      { '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
      { '<leader>d-', function() require('dap').restart() end, desc = 'Restart' },
      { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
      { '<leader>ds', function() require('dap').session() end, desc = 'Session' },
      { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
    },
    config = conf('debug'),
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/')
      pcall(function()
        require('dap-python').setup(mason_path .. 'packages/debugpy/venv/bin/python')
      end)
    end,
  },

  --- Language Specific
  {
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    dependencies = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp' },
    keys = {
      -- stylua: ignore start
      { '<leader>ccp', function() require('crates').show_popup() end, desc = 'Show crate popup', ft = 'toml' },
      { '<leader>cci', function() require('crates').show_crate_popup() end, desc = 'Show crate info', ft = 'toml' },
      { '<leader>ccd', function() require('crates').open_documentation() end, desc = 'Show crate docs', ft = 'toml' },
    },
    config = conf('crates'),
  },
  {
    'olexsmir/gopher.nvim',
    ft = { 'go', 'gomod' },
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('gopher.dap').setup()
    end,
  },
  { 'mrcjkb/rustaceanvim', ft = 'rust', version = '^3', config = conf('rustacean') },

  --- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'LazyFile', 'VeryLazy' },
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    version = false,
    dependencies = {
      'HiPhish/rainbow-delimiters.nvim',
      'nvim-treesitter/nvim-treesitter-context',
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
          -- When in diff mode, we want to use the default
          -- vim text objects c & C instead of the treesitter ones.
          local move = require('nvim-treesitter.textobjects.move') ---@type table<string,fun(...)>
          local configs = require('nvim-treesitter.configs')
          for name, fn in pairs(move) do
            if name:find('goto') == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module('textobjects.move')[name] ---@type table<string,string>
                  for key, query in pairs(config or {}) do
                    if q == query and key:find('[%]%[][cC]') then
                      vim.cmd('normal! ' .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
        end,
      },
    },
    keys = {
      { '<C-space>', desc = 'Increment selection' },
      { '<BS>', desc = 'Decrement selection', mode = 'x' },
    },
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
  { 'j-hui/fidget.nvim', tag = 'v1.2.0', event = 'LspAttach', config = conf('fidget') },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
  {
    'willothy/nvim-cokeline',
    event = 'LazyFile',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    config = conf('cokeline'),
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { { 'MunifTanjim/nui.nvim', module = 'nui' }, { 'rcarriga/nvim-notify', module = 'notify' } },
    config = conf('noice'),
  },
  {
    'rcarriga/nvim-notify',
    init = function()
      -- If noice is not enabled, Load notify on VeryLazy
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
      { '<leader>nw', '<CMD>NomoWork<CR>', desc = 'Nomo - Start Work' },
      { '<leader>nb', '<CMD>NomoBreak<CR>', desc = 'Nomo - Start Break' },
      { '<leader>ns', '<CMD>NomoStop<CR>', desc = 'Nomo - Stop Timer' },
    },
    config = conf('nomodoro'),
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
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
        ---@diagnostic disable-next-line: param-type-mismatch
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end
    end,
    config = conf('neotree'),
  },
  {
    'nyngwang/NeoZoom.lua',
    cmd = 'NeoZoomToggle',
    name = 'neo-zoom',
    keys = {
      { '<leader><CR>', ':NeoZoomToggle<CR>', desc = 'Zoom Window' },
    },
    config = conf('neozoom'),
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    -- branch = '0.1.x',
    version = false,
    dependencies = {
      'debugloop/telescope-undo.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-frecency.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        enabled = vim.fn.executable('make') == 1,
        config = function()
          util.on_load('telescope.nvim', function()
            require('telescope').load_extension('fzf')
          end)
        end,
      },
      { 'nvim-telescope/telescope-symbols.nvim' },
    },
    keys = {
      -- General
      { '<leader>:', '<CMD>Telescope command_history<CR>', desc = 'Command History' },
      { '<leader>,', '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>', desc = 'Switch buffer' },
      { '<leader>/', util.telescope('live_grep'), desc = 'Grep (root dir)' },
      -- Files
      { '<leader>fF', util.telescope('files'), desc = 'Find files (root dir)' },
      { '<leader>ff', util.telescope('files', { cwd = vim.loop.cwd() }), desc = 'Find files (cwd)' },
      { '<leader>fR', '<CMD>Telescope frecency<CR>', desc = 'Recent files' },
      { '<leader>fr', '<CMD>Telescope frecency workspace=CWD<CR>', desc = 'Recent files (cwd)' },
      -- Search
      { '<leader>tm', '<CMD>Telescope marks<CR>', desc = 'Marks' },
      { '<leader>t"', '<CMD>Telescope registers<CR>', desc = 'Registers' },
      { '<leader>tk', '<CMD>Telescope keymaps<CR>', desc = 'Keymaps' },
      {
        '<leader>ts',
        '<CMD>lua require"telescope.builtin".symbols{ sources = { "emoji", "gitmoji", "nerd" } }<CR>',
        desc = 'Emoji',
      },
      { '<leader>tu', '<CMD>Telescope undo<CR>', desc = 'Undo history' },
      -- Misc
      {
        '<leader>uC',
        function()
          vim.api.nvim_exec_autocmds('User', { pattern = 'ColorSchemeLoad' })
          vim.cmd('Telescope colorscheme')
        end,
        desc = 'Switch colorscheme',
        noremap = true,
      },
      { '<leader>uo', '<CMD>Telescope vim_options<CR>', desc = 'Options', noremap = true },
    },
    config = conf('telescope'),
  },
  {
    'alexghergh/nvim-tmux-navigation',
    opts = {
      disable_when_zoomed = true, -- defaults to false
    },
    keys = {
      { '<C-h>', '<CMD>NvimTmuxNavigateLeft<CR>', desc = 'TmuxNavigateLeft' },
      { '<C-j>', '<CMD>NvimTmuxNavigateDown<CR>', desc = 'TmuxNavigateDown' },
      { '<C-k>', '<CMD>NvimTmuxNavigateUp<CR>', desc = 'TmuxNavigateUp' },
      { '<C-l>', '<CMD>NvimTmuxNavigateRight<CR>', desc = 'TmuxNavigateRight' },
      { '<C-\\>', '<CMD>NvimTmuxNavigateLastActive<CR>', desc = 'TmuxNavigateLast' },
    },
    config = true,
  },
  { 'wakatime/vim-wakatime', event = 'InsertEnter' },
  { 'folke/which-key.nvim', event = 'VeryLazy', config = conf('whichkey') },
}
