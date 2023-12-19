local map = require('core.helpers').map
return function()
  map('n', '<leader>hm', "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = 'Mark file with harpoon' })
  map('n', '<leader>ha', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = 'Show harpoon marks' })
  map('n', '<leader>1', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = 'Go to Harpoon File 1' })
  map('n', '<leader>2', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = 'Go to Harpoon File 2' })
  map('n', '<leader>3', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = 'Go to Harpoon File 3' })
  map('n', '<leader>4', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = 'Go to Harpoon File 4' })
  map('n', '<leader>5', "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", { desc = 'Go to Harpoon File 5' })
  map('n', '<leader>6', "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", { desc = 'Go to Harpoon File 6' })

  require('harpoon').setup({
    global_settings = {
      -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
      save_on_toggle = true,

      -- saves the harpoon file upon every change. disabling is unrecommended.
      save_on_change = true,

      -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
      enter_on_sendcmd = false,

      -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
      tmux_autoclose_windows = false,

      -- filetypes that you want to prevent from adding to the harpoon list menu.
      excluded_filetypes = { 'harpoon' },

      -- set marks specific to each git branch inside git repository
      mark_branch = false,

      -- enable tabline with harpoon marks
      tabline = false,
      tabline_prefix = '   ',
      tabline_suffix = '   ',
    },
  })
end
