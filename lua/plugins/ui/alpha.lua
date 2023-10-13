return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local has_alpha, alpha = pcall(require, 'alpha')

    if not has_alpha then
      return
    end

    local fn = vim.fn

    local header = {
      type = 'text',
      val = {
        [[⣤⣤⡀⠀⠀⠀⠀⠀⠀⠀⣤⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣤⣄⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⡄⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⡆⠀⠀⠀⠀⠀⠀⣾⣿⣿⠃⠘⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⣿⣿⡇⠀⠀⢀⣠⣤⣤⣤⣤⣤⣄⠀⠀⠀⣤⣤⡄⠀⠀⠀⠀⠀⢀⣤⣤⡄⠀⣤⣤⣤⣤⣤⣤⣀⠀⠀⠀⢿⣿⣿⡄⠀⠀⠀⠀⣴⣿⣿⠇⠀⢠⣤⣤⠀⠀⣤⣤⣤⣤⣤⣤⣠⣤⣤⣤⣤⡀⠀]],
        [[⣿⣿⡟⣿⣿⣷⣄⠀⠀⠀⣿⣿⡇⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⣿⣿⡇⠀⠀⠀⠀⠀⣾⣿⣿⠁⠀⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠘⣿⣿⣧⠀⠀⠀⢠⣿⣿⡟⠀⠀⢸⣿⣿⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧]],
        [[⣿⣿⡇⠘⢿⣿⣿⣦⠀⠀⣿⣿⡇⠀⣿⣿⡟⠉⠉⠉⠉⠉⣿⣿⣷⠀⣿⣿⡇⠀⠀⠀⠀⣰⣿⣿⠏⠀⢀⣉⣉⣉⣉⣉⡙⣿⣿⡇⠀⠀⢹⣿⣿⣇⠀⢀⣿⣿⣿⠁⠀⠀⢸⣿⣿⠀⢸⣿⣿⠉⠉⠉⢹⣿⣿⡏⠉⢹⣿⣿]],
        [[⣿⣿⡇⠀⠈⠻⣿⣿⣷⡀⣿⣿⡇⠀⣿⣿⡇⠀⠀⠀⠀⠀⣿⣿⣿⠀⣿⣿⡇⠀⠀⠀⣴⣿⣿⡟⠀⣰⣿⣿⣿⣿⣿⣿⡇⣿⣿⡇⠀⠀⠀⢻⣿⣿⡄⣼⣿⣿⠃⠀⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⡇⠀⢸⣿⣿]],
        [[⣿⣿⡇⠀⠀⠀⠘⢿⣿⣿⣿⣿⡇⠀⣿⣿⡇⠀⠀⠀⠀⠀⣿⣿⣿⠀⣿⣿⡇⠀⣠⣼⣿⣿⠟⠀⠀⣿⣿⡟⠉⠉⠉⠉⠁⣿⣿⡇⠀⠀⠀⠈⢿⣿⣿⣿⣿⠟⠀⠀⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⡇⠀⢸⣿⣿]],
        [[⣿⣿⡇⠀⠀⠀⠀⠈⠻⣿⣿⣿⡇⠀⢿⣿⣿⣶⣶⣶⣶⣶⣿⣿⡏⠀⣿⣿⣷⣾⣿⣿⡿⠋⠀⠀⠀⢿⣿⣷⣶⣶⣶⣶⣶⣿⣿⠇⠀⠀⠀⠀⠸⣿⣿⣿⡿⠀⠀⠀⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⡇⠀⢸⣿⣿]],
        [[⣿⣿⡇⠀⠀⠀⠀⠀⠀⠙⣿⣿⠇⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⢻⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⢸⣿⣿⠁⠀⠀⠀⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⡇⠀⢸⣿⣿]],
      },
      opts = {
        position = 'center',
        hl = 'Keyword',
      },
    }

    local function getGreeting()
      local tableTime = os.date('*t')
      local datetime = os.date(' %Y-%m-%d   %-I:%M%p')
      local hour = tableTime.hour
      local greetingsTable = {
        [1] = '  Sleep well!',
        [2] = '󱗆  Good morning!',
        [3] = '󰖨  Good afternoon!',
        [4] = '󰖚  Good evening!',
        [5] = '󰖔  Good night!',
      }
      local greetingIndex = 0
      if hour == 0 or hour < 7 then
        greetingIndex = 1
      elseif hour < 12 then
        greetingIndex = 2
      elseif hour >= 12 and hour < 18 then
        greetingIndex = 3
      elseif hour >= 18 and hour < 21 then
        greetingIndex = 4
      elseif hour >= 21 then
        greetingIndex = 5
      end
      return datetime .. '  ' .. greetingsTable[greetingIndex]
    end

    local greeting = getGreeting()

    local sub_header = {
      type = 'text',
      val = greeting,
      opts = {
        position = 'center',
        hl = 'AlphaHeaderLabel',
      },
    }

    local function buttons()
      local keybind_opts = { silent = true, noremap = true }
      -- General
      vim.api.nvim_buf_set_keymap(0, 'n', 'n', ':ene <BAR> startinsert <CR>', keybind_opts)

      -- Harpoon
      vim.api.nvim_buf_set_keymap(0, 'n', 'h', ':lua require("harpoon.ui").toggle_quick_menu()<cr>', keybind_opts)

      -- Neo-tree
      vim.api.nvim_buf_set_keymap(
        0,
        'n',
        'e',
        ':lua require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })<cr>',
        keybind_opts
      )

      -- Telescope
      vim.api.nvim_buf_set_keymap(0, 'n', 'j', ':Telescope oldfiles<CR>', keybind_opts)
      vim.api.nvim_buf_set_keymap(0, 'n', 'k', ':lua require"core.helpers".project_files() <CR>', keybind_opts)

      -- Lazy
      vim.api.nvim_buf_set_keymap(0, 'n', 'l', ':Lazy update<CR>', keybind_opts)

      -- Configs
      vim.api.nvim_buf_set_keymap(0, 'n', 'm', ':e ~/.config/NovaVim/lua/core/keymaps.lua<CR>', keybind_opts)
      vim.api.nvim_buf_set_keymap(0, 'n', 'o', ':e ~/.config/NovaVim/lua/core/options.lua<CR>', keybind_opts)

      -- Quit
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', keybind_opts)

      -- NOTE: This is a mess, if you add or remove shortcuts the table below will have to be played around with
      -- to get the color highlights to look right.
      local buttons_hl = {
        { 'AlphaButtons', 0, 20 },
        { 'AlphaShortcut', 21, 23 },
        { 'Comment', 24, 28 },
        { 'AlphaButtons', 30, 49 },
        { 'AlphaShortcut', 51, 55 },
        { 'Comment', 56, 62 },
        { 'AlphaButtons', 63, 83 },
        { 'AlphaShortcut', 84, 89 },
      }

      local buttons_ln = {
        { 'Comment', 0, 89 },
      }

      return {
        {
          type = 'text',
          val = {
            '                        │                           │                       ',
            '   New File       n    │    󰙅   Explorer      e    │    󰒲   Lazy Update   l',
            '󱨻   Recent Files   j    │                           │                       ',
            '   Git Files      k    │                           │    󰌓   Edit Keymaps  m',
            '󱡅   Harpoon        h    │                           │       Edit Options  o',
            '                        │                           │                       ',
            '                        │    󰗼   Quit          q    │                       ',
            '                        │                           │                       ',
          },
          opts = {
            position = 'center',
            hl = {
              buttons_ln,
              buttons_hl,
              buttons_hl,
              buttons_hl,
              buttons_hl,
              buttons_ln,
              buttons_hl,
              buttons_ln,
            },
          },
        },
      }
    end

    local button_group = { type = 'group', val = buttons }

    local function footer_text()
      local lazy_stats = require('lazy').stats()
      local ms = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
      local total_plugins = '⚡ Lazy loaded ' .. lazy_stats.count .. ' plugins in ' .. ms .. ' ms'
      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = { 'LazyVimStarted' },
        callback = function()
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
      return total_plugins
    end

    local footer = {
      type = 'text',
      val = function()
        return footer_text()
      end,
      opts = {
        position = 'center',
        hl = 'Comment',
      },
    }

    local marginTopPercent = 0.25
    local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

    local config = {
      layout = {
        { type = 'padding', val = headerPadding },
        header,
        { type = 'padding', val = 2 },
        sub_header,
        { type = 'padding', val = 2 },
        button_group,
        { type = 'padding', val = 2 },
        footer,
      },
    }

    alpha.setup(config)

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'AlphaReady',
        callback = function()
          require('lazy').show()
        end,
      })
    end
  end,
}
