local map = require('core.helpers').map
local toggle = require('core.helpers').toggle
local wk = require('which-key')

---
-- General Keymappings
---

-- Better window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Resize with arrows
map('n', '<C-Up>', ':resize +5<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', ':resize -5<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', ':vertical resize -5<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', ':vertical resize +5<CR>', { desc = 'Increase window width' })

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Move lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Lazy
map('n', '<leader>l', ':Lazy<CR>', { desc = 'Open Lazy' })

-- Quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

---
-- Which-key Mapping Table
---

wk.register({
  c = {
    name = 'Coding',
  },
  u = {
    name = 'UI',
    l = {
      function()
        toggle('listchars', { enable = 'set list', disable = 'set nolist' })
      end,
      'Toggle listchars',
      noremap = true,
    },
  },
}, { prefix = '<leader>' })
