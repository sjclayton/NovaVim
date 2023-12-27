local icons = require('core.icons')
local map = require('core.helpers').map
local toggle = require('core.helpers').toggle

local wk = require('which-key')

---
-- General Keymappings
---

-- Better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Better window navigation
map('n', '<C-q>', '<C-w>q', { desc = 'Close window' })
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
map('i', '<a-j>', '<ESC><CMD>m .+1<CR>==gi', { desc = 'Move line down' })
map('i', '<a-k>', '<ESC><CMD>m .-2<CR>==gi', { desc = 'Move line up' })
map('n', '<a-j>', '<CMD>m .+1<CR>==', { desc = 'Move line down' })
map('n', '<a-k>', '<CMD>m .-2<CR>==', { desc = 'Move line up' })
map('v', '<a-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<a-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Jumping
map('n', '<BS>', '^', { desc = 'Start of line (non-blank)' })

-- Sorting
map('v', '<leader>s', "<ESC><CMD>'<,'>sort<CR>", { desc = 'Sort visual selection' })
map('v', '<leader>r', "<ESC><CMD>'<,'>sort!<CR>", { desc = 'Sort visual selection (reverse)' })

---
-- Misc
---

-- Clear search with <ESC>
map({ 'n', 'i' }, '<ESC>', '<CMD>noh<CR><ESC>', { desc = 'Escape and clear hlsearch' })

-- Disable some things
map('n', 'Q', '<NOP>')

-- Useful stuff
map('n', '<leader>fl', ":lua print(vim.fn.expand('%:h'))<CR>", { desc = 'Show CWD relative to project root' })
map(
  'n',
  'gx',
  '<CMD>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>',
  { desc = 'Open link under cursor in browser' }
)
map('n', '<leader>qq', '<CMD>qa<CR>', { desc = 'Quit all' })

---
-- Which-key Mapping Table
---

wk.register({
  b = {
    name = icons.ui.Files .. 'Buffers',
    j = { '<Plug>(cokeline-pick-focus)', 'Jump to buffer', noremap = true },
    C = {
      '<Plug>(cokeline-pick-close)',
      'Pick buffer to close',
      noremap = true,
    },
    n = { '<Plug>(cokeline-focus-next)', 'Cycle next buffer', noremap = true },
    p = { '<Plug>(cokeline-focus-prev)', 'Cycle previous buffer', noremap = true },
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
  l = {
    name = icons.ui.Gear .. 'LSP',
    i = { '<CMD>LspInfo<CR>', 'LSP Info', noremap = true },
    r = { '<CMD>LspRestart<CR>', 'Restart LSP', noremap = true },
  },
  u = {
    name = icons.ui.UI .. 'UI/Utils',
    c = {
      function()
        toggle('Listchars', { enable = 'set list', disable = 'set nolist' })
      end,
      'Toggle listchars',
      noremap = true,
    },
    n = {
      function()
        toggle('Line numbers', { enable = 'set nonumber', disable = 'set number' })
      end,
      'Toggle line numbers',
      noremap = true,
    },
    l = { '<CMD>Lazy<CR>', 'Open Lazy', noremap = true },
    Z = {
      '<CMD>ZenMode<CR>',
      'Toggle zen mode',
      noremap = true,
    },
  },
  x = {
    name = icons.diagnostics.Warn .. 'Diagnostics',
  },
  ['<space>'] = { '<C-^>', 'Jump to alternate file', noremap = true },
}, { prefix = '<leader>' })
