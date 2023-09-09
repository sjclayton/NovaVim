return {
  {
    'ThePrimeagen/harpoon',
    lazy = true,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    keys = {
      { '<leader>hm', "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = 'Mark file with harpoon' },
      { '<leader>hn', "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = 'Go to next harpoon mark' },
      { '<leader>hp', "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = 'Go to previous harpoon mark' },
      { '<leader>ha', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = 'Show harpoon marks' },

      { '<leader>1', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = 'Go to Harpoon File 1' },
      { '<leader>2', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = 'Go to Harpoon File 2' },
      { '<leader>3', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = 'Go to Harpoon File 3' },
      { '<leader>4', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = 'Go to Harpoon File 4' },
    },
  },
}
