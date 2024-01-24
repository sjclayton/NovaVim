local helper = require('core.helpers')
local icons = require('core.icons')
local util = require('core.util')

local conf = function(plugin)
  return require('plugins.config.' .. plugin)
end

return {
  --- General
  { 'Bekaboo/deadcolumn.nvim', event = { 'LazyFile', 'VeryLazy' }, config = conf('deadcolumn') },
  {
    'sjclayton/harpoon',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
      { '<leader>hm', "<CMD>lua require('harpoon.mark').add_file()<CR>", desc = 'Mark file with harpoon' },
      { '<leader>ha', "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = 'Show harpoon marks' },
      { '<leader>1', "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", desc = 'Go to Harpoon File 1' },
      { '<leader>2', "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", desc = 'Go to Harpoon File 2' },
      { '<leader>3', "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", desc = 'Go to Harpoon File 3' },
      { '<leader>4', "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", desc = 'Go to Harpoon File 4' },
      { '<leader>5', "<CMD>lua require('harpoon.ui').nav_file(5)<CR>", desc = 'Go to Harpoon File 5' },
      { '<leader>6', "<CMD>lua require('harpoon.ui').nav_file(6)<CR>", desc = 'Go to Harpoon File 6' },
    },
    config = conf('harpoon'),
  },
  {
    'lukas-reineke/headlines.nvim',
    ft = 'markdown',
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
    '3rd/image.nvim',
    ft = 'markdown',
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
      { '<leader>aa', ':Gen<CR>', desc = 'Select AI prompt', mode = { 'n', 'v' } },
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
        desc = 'Swap value',
      },
    },
    config = conf('alternatetoggler'),
  },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', dependencies = 'hrsh7th/nvim-cmp', config = conf('autopairs') },
  { 'numToStr/Comment.nvim', event = 'VeryLazy', config = true },
  { 'lewis6991/gitsigns.nvim', event = 'LazyFile', config = conf('gitsigns') },
  {
    'shellRaining/hlchunk.nvim',
    event = 'LazyFile',
    keys = {
      {
        '<leader>ub',
        function()
          helper.toggle_cmd('Scope line numbers', { enable = 'EnableHLLineNum', disable = 'DisableHLLineNum' })
        end,
        desc = 'Toggle scope line numbers',
      },
      {
        '<leader>uB',
        function()
          helper.toggle_cmd('Scope highlight', { enable = 'EnableHLChunk', disable = 'DisableHLChunk' })
        end,
        desc = 'Toggle scope chunk highlight',
      },

      {
        '<leader>ui',
        function()
          helper.toggle_cmd('Indention highlights', { enable = 'EnableHLIndent', disable = 'DisableHLIndent' }, true)
        end,
        desc = 'Toggle indention highlights',
      },
    },
    config = conf('hlchunk'),
  },
  { 'echasnovski/mini.ai', event = 'VeryLazy', version = false, config = conf('mini-ai') },
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
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = { 'plenary.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {
      disable_hint = true,
      kind = 'split_above',
      signs = {
        -- { CLOSED, OPENED }
        hunk = { '', '' },
        item = { icons.ui.ChevronRight, icons.ui.ChevronDown },
        section = { icons.ui.ChevronRight, icons.ui.ChevronDown },
      },
    },
    keys = {
      { '<leader>gn', '<CMD>Neogit<CR>', desc = 'Open Neogit' },
    },
  },
  { 'NvChad/nvim-colorizer.lua', cmd = 'ColorizerToggle', name = 'nvim-colorizer', config = conf('colorizer') },
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
    'hedyhli/outline.nvim',
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { { '<leader>co', '<CMD>Outline<CR>', desc = 'Toggle outline' } },
    config = conf('outline'),
  },
  {
    'rgroli/other.nvim',
    cmd = { 'Other', 'OtherTabNew', 'OtherSplit', 'OtherVSplit' },
    keys = {
      { '<leader>oo', '<CMD>Other<CR>', desc = 'Open other file' },
      { '<leader>ot', '<CMD>Other test<CR>', desc = 'Open test file' },
      { '<leader>ov', '<CMD>OtherVSplit<CR>', desc = 'Open other file (vsplit)' },
      { '<leader>oh', '<CMD>OtherSplit<CR>', desc = 'Open other file (split)' },
    },
    config = conf('other-nvim'),
  },
  {
    'folke/todo-comments.nvim',
    event = 'LazyFile',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      -- stylua: ignore start
      { ']t', function() require('todo-comments').jump_next() end, desc = 'Next todo comment', },
      { '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous todo comment', },
      -- stylua: ignore end
      { '<leader>xT', '<CMD>TodoTrouble<CR>', desc = 'Todo Comments (Trouble)' },
      { '<leader>xt', '<CMD>TodoTrouble keywords=TODO,FIX,FIXME<CR>', desc = 'Todo/Fix/Fixme (Trouble)' },
      { '<leader>tT', '<CMD>TodoTelescope<CR>', desc = 'Todo Comments' },
      { '<leader>tt', '<CMD>TodoTelescope keywords=TODO,FIX,FIXME<CR>', desc = 'Todo/Fix/Fixme' },
    },
    config = true,
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
      { '<leader>xd', '<CMD>TroubleToggle document_diagnostics<CR>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xw', '<CMD>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xl', '<CMD>TroubleToggle loclist<CR>', desc = 'Location List (Trouble)' },
      { '<leader>xq', '<CMD>TroubleToggle quickfix<CR>', desc = 'Quickfix List (Trouble)' },
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
    event = 'LazyFile',
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
    event = 'BufWritePre',
    cmd = 'ConformInfo',
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
          -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
          -- dap.listeners.before.event_exited['dapui_config'] = dapui.close
          -- stylua: ignore end
        end,
      },
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    },
    -- stylua: ignore
    keys = {
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint condition' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Run / continue' },
      { '<leader>da', function() require('dap').continue({ before = util.dap_run_args }) end, desc = 'Run with args' },
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
  -- Testing
  {
    'nvim-neotest/neotest',
    ft = { 'go', 'python', 'rust', 'zig' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- Adapters
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
      'rouge8/neotest-rust',
      'lawrence-laz/neotest-zig',
    },
    keys = {
      -- stylua: ignore start
      { '[n', '<CMD>lua require("neotest").jump.prev({ status="failed" })<CR>', desc = 'Previous failing test' },
      { ']n', '<CMD>lua require("neotest").jump.next({ status="failed" })<CR>', desc = 'Next failing test' },
      { '<leader>cta', '<CMD>lua require("neotest").run.run(vim.fn.getcwd())<CR>', desc = 'Run all tests (cwd)' },
      { '<leader>ctf', '<CMD>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = 'Run all tests (file)' },
      { '<leader>ctn', '<CMD>lua require("neotest").run.run()<CR>', desc = 'Run nearest test' },
      { '<leader>ctl', '<CMD>lua require("neotest").run.run_last()<CR>', desc = 'Run last test' },
      { '<leader>cto', '<CMD>lua require("neotest").output.open()<CR>', desc = 'Show test output' },
      { '<leader>ctp', '<CMD>lua require("neotest").output_panel.toggle()<CR>', desc = 'Toggle test output panel' },
      { '<leader>cts', '<CMD>lua require("neotest").summary.toggle()<CR>', desc = 'Toggle test summary' },
      { '<leader>ctw', '<CMD>lua require("neotest").watch.toggle(vim.fn.expand("%"))<CR>', desc = 'Watch tests (file)' },
    },
    config = conf('testing'),
  },

  --- Language Specific
  -- Go
  {
    'olexsmir/gopher.nvim',
    ft = { 'go', 'gomod' },
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('gopher.dap').setup()
    end,
  },
  -- Python
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/')
      pcall(function()
        require('dap-python').setup(mason_path .. 'packages/debugpy/venv/bin/python')
      end)
    end,
  },
  -- Rust
  {
    'Saecki/crates.nvim',
    event = 'BufRead Cargo.toml',
    dependencies = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp' },
    keys = {
      -- stylua: ignore start
      { '<leader>crp', function() require('crates').show_popup() end, desc = 'Show crate popup' },
      { '<leader>cri', function() require('crates').show_crate_popup() end, desc = 'Show crate info' },
      { '<leader>crd', function() require('crates').open_documentation() end, desc = 'Show crate docs' },
    },
    config = conf('crates'),
  },
  {
    'mrcjkb/rustaceanvim',
    ft = 'rust',
    version = '^3',
    config = conf('rustacean'),
  },

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
    dependencies = { 'sjclayton/harpoon', 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
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
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
      {
        '<leader>uz',
        function()
          helper.toggle_cmd('Zen mode', { toggle = 'ZenMode' }, false)
        end,
        desc = 'Toggle zen mode',
      },
    },
    config = conf('zenmode'),
  },

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
  {
    'folke/tokyonight.nvim',
    event = 'User ColorSchemeLoad',
    priority = 1000,
    name = 'tokyonight',
  },

  --- Utils
  {
    'tris203/hawtkeys.nvim',
    cmd = { 'Hawtkeys', 'HawtkeysAll', 'HawtkeysDupes' },
    branch = 'issue81',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    config = conf('hawtkeys'),
  },
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
      { '<leader>up', '<CMD>NomoWork<CR>', desc = 'Nomodoro - Start timer' },
      { '<leader>uk', '<CMD>NomoBreak<CR>', desc = 'Nomodoro - Start break' },
      { '<leader>uP', '<CMD>NomoStop<CR>', desc = 'Nomodoro - Stop timer' },
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
      { '<leader><CR>', '<CMD>NeoZoomToggle<CR>', desc = 'Zoom window' },
    },
    config = conf('neozoom'),
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
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
      { '<leader>:', '<CMD>Telescope command_history<CR>', desc = 'Command history' },
      { '<leader>,', '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>', desc = 'Switch buffer' },
      { '<leader>/', util.telescope('live_grep'), desc = 'Grep (root dir)' },
      -- Files
      { '<leader>fF', util.telescope('files'), desc = 'Find files (root dir)' },
      { '<leader>ff', util.telescope('files', { cwd = vim.loop.cwd() }), desc = 'Find files (cwd)' },
      { '<leader>fR', '<CMD>Telescope frecency<CR>', desc = 'Recent files' },
      { '<leader>fr', '<CMD>Telescope frecency workspace=CWD<CR>', desc = 'Recent files (cwd)' },
      -- Search
      { '<leader>tb', '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>', desc = 'Buffers' },
      {
        '<leader>te',
        '<CMD>lua require"telescope.builtin".symbols{ sources = { "emoji", "gitmoji", "nerd" } }<CR>',
        desc = 'Emoji',
      },
      { '<leader>th', '<CMD>Telescope help_tags<CR>', desc = 'Help' },
      { '<leader>tk', '<CMD>Telescope keymaps<CR>', desc = 'Keymaps' },
      { '<leader>tm', '<CMD>Telescope marks<CR>', desc = 'Marks' },
      { '<leader>tr', '<CMD>Telescope registers<CR>', desc = 'Registers' },
      { '<leader>tu', '<CMD>Telescope undo<CR>', desc = 'Undo history' },
      -- Misc
      {
        '<leader>uC',
        function()
          vim.api.nvim_exec_autocmds('User', { pattern = 'ColorSchemeLoad' })
          vim.cmd('Telescope colorscheme')
        end,
        desc = 'Select colorscheme',
      },
      { '<leader>uo', '<CMD>Telescope vim_options<CR>', desc = 'Options' },
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
