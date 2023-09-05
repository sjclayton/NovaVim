return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local has_alpha, alpha = pcall(require, 'alpha')

    if not has_alpha then
      return
    end

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
      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = { 'AlphaReady' },
        callback = function(_)
          -- General
          vim.api.nvim_buf_set_keymap(0, 'n', 'n', ':ene <BAR> startinsert <CR>', keybind_opts)

          -- Telescope
          vim.api.nvim_buf_set_keymap(0, 'n', 'r', ':Telescope oldfiles<CR>', keybind_opts)
          vim.api.nvim_buf_set_keymap(0, 'n', 'g', ':<CMD>lua require"core.helpers".project_files()<CR>', keybind_opts)

          -- Lazy
          vim.api.nvim_buf_set_keymap(0, 'n', 'l', ':Lazy update<CR>', keybind_opts)

          -- Quit
          vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', keybind_opts)
        end,
      })

      local buttons_hl = {
        { 'AlphaButtons', 1, 4 },
        { 'AlphaButtons', 5, 20 },
        { 'AlphaShortcut', 20, 25 },
        { 'AlphaLine', 25, 32 },
        { 'AlphaButtons', 32, 38 },
        { 'AlphaButtons', 38, 50 },
        { 'AlphaShortcut', 51, 55 },
        { 'AlphaLine', 55, 62 },
        { 'AlphaButtons', 62, 68 },
        { 'AlphaButtons', 68, 83 },
        { 'AlphaShortcut', 83, 88 },
      }
      return {
        {
          type = 'text',
          val = {
            '                        │                           │                       ',
            '   New File       n    │       terminal      t    │    󰒲   Lazy Update   l',
            '󱨻   Recent Files   r    │       lf            ;    │                       ',
            '   Git Files      g    │       search        s    │                       ',
            'ﯠ   harpoon        k    │    פּ   nvim-tree     j    │                       ',
            '                        │                           │                       ',
            '                        │    󰗼   Quit          q    │                       ',
            '                        │                           │                       ',
          },
          opts = {
            position = 'center',
            hl = {
              buttons_hl,
              buttons_hl,
              buttons_hl,
              buttons_hl,
              buttons_hl,
              buttons_hl,
              buttons_hl,
              buttons_hl,
            },
          },
        },
      }
    end

    local button_group = { type = 'group', val = buttons }

    local function footer_text()
      ---@diagnostic disable-next-line:undefined-field
      local lazy_stats = require('lazy').stats()
      local ms = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
      -- stylua: ignore
      local total_plugins = ' ⚡ Lazy loaded ' .. lazy_stats.loaded .. ' of ' .. lazy_stats.count .. ' plugins in ' .. ms .. ' ms'
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

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'AlphaReady',
        callback = function()
          require('lazy').show()
        end,
      })
    end

    local config = {
      layout = {
        { type = 'padding', val = 6 },
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
  end,
}