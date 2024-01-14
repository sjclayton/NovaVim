local helper = require('core.helpers')
local icons = require('core.icons')
local map = require('core.helpers').map
local util = require('core.util')

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

if not util.has('nvim-tmux-navigation') then
  map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
  map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
  map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
  map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
end

-- Resize windows
map('n', '<C-M-k>', ':resize +5<CR>', { desc = 'Increase window height' })
map('n', '<C-M-j>', ':resize -5<CR>', { desc = 'Decrease window height' })
map('n', '<C-M-h>', ':vertical resize -5<CR>', { desc = 'Decrease window width' })
map('n', '<C-M-l>', ':vertical resize +5<CR>', { desc = 'Increase window width' })

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Yanking and pasting
map('x', '<leader>p', '"_dP', { desc = 'Paste preserved' })

-- Line operations
map('n', 'J', 'mzJ`z', { desc = 'Join lines' })

map('i', '<a-j>', '<ESC><CMD>m .+1<CR>==gi', { desc = 'Move line down' })
map('i', '<a-k>', '<ESC><CMD>m .-2<CR>==gi', { desc = 'Move line up' })
map('n', '<a-j>', '<CMD>m .+1<CR>==', { desc = 'Move line down' })
map('n', '<a-k>', '<CMD>m .-2<CR>==', { desc = 'Move line up' })
map('v', '<a-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<a-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Jumping
map('n', '<BS>', '^', { desc = 'Start of line (non-blank)' })
map('n', 'G', 'Gzz', { desc = 'Last line' })

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
map(
  'n',
  'gx',
  '<CMD>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>',
  { desc = 'Open link under cursor in browser' }
)
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<CMD>w<CR><ESC>', { desc = 'Save file' })
map('n', '<leader>qq', '<CMD>qa<CR>', { desc = 'Quit' })
map('n', '<leader>qQ', '<CMD>qa!<CR>', { desc = 'Quit (force)' })
map('n', '<leader>qs', '<CMD>wq<CR>', { desc = 'Save and quit' })

---
-- Which-key Mapping Table
---

wk.register({
  b = {
    name = icons.ui.Files .. 'Buffers',
    j = { '<Plug>(cokeline-pick-focus)', 'Jump to buffer' },
    c = { '<Plug>(cokeline-pick-close)', 'Pick buffer to close' },
    n = { '<Plug>(cokeline-focus-next)', 'Cycle next buffer' },
    p = { '<Plug>(cokeline-focus-prev)', 'Cycle previous buffer' },
  },
  c = {
    name = icons.ui.Code .. 'Code',
    c = {
      name = icons.kinds.Package .. 'Rust Crates',
    },
    t = {
      name = icons.ui.Test .. 'Testing',
    },
  },
  d = {
    name = icons.ui.Bug .. 'Debug',
  },
  f = {
    name = icons.kinds.File .. 'File',
  },
  g = {
    name = icons.ui.Git .. 'Git',
  },
  n = {
    name = icons.ui.Notes .. 'Notes',
    f = { '<CMD>Telescope frecency workspace=notes<CR>', 'Recent notes' },
    j = { '<CMD>ObsidianToday<CR>', 'Journal - Today' },
    y = { '<CMD>ObsidianYesterday<CR>', 'Journal - Yesterday' },
    n = {
      function()
        vim.ui.input({ prompt = 'Note title:' }, function(input)
          if input ~= nil then
            vim.cmd('ObsidianNew ' .. input)
          else
            return
          end
        end)
      end,
      'New note',
    },
    r = {
      function()
        local current_name = vim.fn.expand('%:t:r')
        vim.ui.input({ prompt = 'Rename note:', default = current_name }, function(input)
          if input ~= nil then
            vim.cmd('ObsidianRename ' .. input)
          else
            return
          end
        end)
      end,
      'Rename note',
    },
    s = { '<CMD>ObsidianSearch<CR>', 'Search notes' },
    t = { '<CMD>ObsidianTemplate<CR>', 'Insert template' },
  },
  q = {
    name = icons.ui.Exit .. 'Quit',
  },
  t = {
    name = icons.ui.Telescope .. 'Telescope',
  },
  l = {
    name = icons.ui.Gear .. 'LSP',
    i = { '<CMD>LspInfo<CR>', 'LSP Info' },
    r = { '<CMD>LspRestart<CR>', 'Restart LSP' },
    s = { '<CMD>LspStop<CR>', 'Stop LSP' },
    S = { '<CMD>LspStart<CR>', 'Start LSP' },
  },
  u = {
    name = icons.ui.UI .. 'UI/Utils',
    c = {
      function()
        helper.toggle('Listchars', { enable = 'set list', disable = 'set nolist' })
      end,
      'Toggle listchars',
    },
    n = {
      function()
        helper.number()
      end,
      'Toggle line numbers',
    },
    N = {
      function()
        helper.toggle('Relative numbers', { enable = 'set norelativenumber', disable = 'set relativenumber' })
      end,
      'Toggle relative line numbers',
    },
    l = { '<CMD>Lazy<CR>', 'Open Lazy' },
    s = {
      function()
        helper.toggle('Spell check', { enable = 'set spell', disable = 'set nospell' })
      end,
      'Toggle spell check',
    },
    t = {
      function()
        helper.toggle('Treesitter context', { enable = 'TSContextToggle', disable = 'TSContextToggle' })
      end,
      'Toggle Treesitter context',
    },
    T = {
      function()
        helper.toggle('Treesitter highlight', { enable = 'TSBufToggle highlight', disable = 'TSBufToggle highlight' })
      end,
      'Toggle Treesitter highlight',
    },
    w = {
      function()
        helper.toggle('Word wrap', { enable = 'set wrap', disable = 'set nowrap' })
      end,
      'Toggle word wrap',
    },
  },
  x = {
    name = icons.diagnostics.Warn .. 'Diagnostics',
  },
  ['<space>'] = { '<C-^>', 'Jump to alternate file' },
}, { prefix = '<leader>' })
