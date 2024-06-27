local helper = require('core.helpers')
local icons = require('core.icons')
local map = require('core.helpers').map

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

if not LazyVim.has('nvim-tmux-navigation') then
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

-- Commenting
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add comment below' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add comment above' })

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

-- Scrolling
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Search navigation
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

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
    d = { LazyVim.ui.bufremove, 'Delete buffer' },
    D = { '<CMD>:bd<CR>', 'Delete buffer and window' },
    c = { '<Plug>(cokeline-pick-close)', 'Pick buffer to close' },
    j = { '<Plug>(cokeline-pick-focus)', 'Jump to buffer' },
    n = { '<Plug>(cokeline-focus-next)', 'Cycle next buffer' },
    p = { '<Plug>(cokeline-focus-prev)', 'Cycle previous buffer' },
  },
  c = {
    name = icons.ui.Code .. 'Code',
    c = {
      function()
        helper.toggle_cmd('Color preview', { toggle = 'ColorizerToggle' }, false)
      end,
      'Toggle color preview',
    },
    r = {
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
    f = { '<CMD>ConformInfo<CR>', 'Show configured formatters' },
    i = { '<CMD>LspInfo<CR>', 'Show active LSP info' },
    r = { '<CMD>LspRestart<CR>', 'Restart LSP' },
    s = { '<CMD>LspStop<CR>', 'Stop LSP' },
    S = { '<CMD>LspStart<CR>', 'Start LSP' },
  },
  u = {
    name = icons.ui.UI .. 'UI/Utils',
    a = {
      function()
        helper.toggle_cmd('Auto pairs', {
          enable = 'lua require("nvim-autopairs").enable()',
          disable = 'lua require("nvim-autopairs").disable()',
        }, true, false)
      end,
      'Toggle auto pairs',
    },
    c = {
      function()
        helper.toggle_cmd('listchars', { enable = 'set list', disable = 'set nolist' })
      end,
      'Toggle listchars',
    },
    d = {
      function()
        helper.diagnostics()
      end,
      'Toggle diagnostics',
    },
    I = { vim.show_pos, 'Inspect position' },
    n = {
      function()
        LazyVim.toggle.number()
      end,
      'Toggle line numbers',
    },
    N = {
      function()
        LazyVim.toggle.option('relativenumber')
      end,
      'Toggle relative line numbers',
    },
    l = { '<CMD>Lazy<CR>', 'Open Lazy' },
    s = {
      function()
        LazyVim.toggle.option('spell')
      end,
      'Toggle spell check',
    },
    S = {
      function()
        helper.toggle_cmd(
          'Colorscheme',
          { enable = 'colorscheme ' .. Secondary_Colorscheme, disable = 'colorscheme ' .. Primary_Colorscheme },
          false,
          true
        )
      end,
      'Swap primary/secondary colorscheme',
    },
    t = {
      function()
        helper.toggle_cmd('Treesitter context', { toggle = 'TSContextToggle' }, true)
      end,
      'Toggle Treesitter context',
    },
    T = {
      function()
        helper.toggle_cmd('Treesitter highlight', { toggle = 'TSBufToggle highlight' }, true)
      end,
      'Toggle Treesitter highlight',
    },
    w = {
      function()
        LazyVim.toggle.option('wrap')
      end,
      'Toggle word wrap',
    },
  },
  x = {
    name = icons.diagnostics.Warn .. 'Diagnostics',
  },
  ['<space>'] = { '<C-^>', 'Jump to alternate file' },
}, { prefix = '<leader>' })
