local icons = require('core.icons')
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
map('i', '<a-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move line down' })
map('i', '<a-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move line up' })
map('n', '<a-j>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
map('n', '<a-k>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
map('v', '<a-j>', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('v', '<a-k>', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })

-- Sorting
map('v', '<leader>s', "<esc><cmd>'<,'>sort<cr>", { desc = 'Sort visual selection' })
map('v', '<leader>r', "<esc><cmd>'<,'>sort!<cr>", { desc = 'Sort visual selection (reverse)' })

---
-- Misc
---

map('n', '<leader>fl', ":lua print(vim.fn.expand('%:h'))<cr>", { desc = 'Show CWD relative to project root' })
map(
  'n',
  'gx',
  '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>',
  { desc = 'Open link under cursor in browser' }
)
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

---
-- Which-key Mapping Table
---

wk.register({
  b = {
    name = icons.ui.Files .. 'Buffers',
    c = {
      ':Bdelete<CR>',
      'Close current buffer',
      noremap = true,
    },
    j = { '<Plug>(cokeline-pick-focus)', 'Jump to buffer', noremap = true },
    C = {
      '<Plug>(cokeline-pick-close)',
      'Pick buffer to close',
      noremap = true,
    },
    n = { '<Plug>(cokeline-focus-next)', 'Cycle next buffer', noremap = true },
    p = { '<Plug>(cokeline-focus-prev)', 'Cycle previous buffer', noremap = true },
    x = {
      ':Bdelete!<CR>',
      'Close current buffer (no confirm)',
      noremap = true,
    },
  },
  c = {
    name = icons.ui.Code .. 'Code',
  },
  f = {
    name = icons.kinds.File .. 'File',
  },
  t = {
    name = icons.ui.Telescope .. 'Telescope',
  },
  u = {
    name = icons.ui.UI .. 'UI',
    c = {
      function()
        toggle('Listchars', { enable = 'set list', disable = 'set nolist' })
      end,
      'Toggle listchars',
      noremap = true,
    },
    l = {
      function()
        toggle('Line numbers', { enable = 'set nonumber', disable = 'set number' })
      end,
      'Toggle line numbers',
      noremap = true,
    },
  },
  ['<space>'] = { '<C-^>', 'Jump to alternate file', noremap = true },
  l = { ':Lazy<CR>', 'Open Lazy', noremap = true },
}, { prefix = '<leader>' })
