local g = vim.g
local o = vim.opt

g.mapleader = ' '
g.maplocalleader = '\\'

o.backup = false
o.clipboard = 'unnamedplus'
o.confirm = true
o.cursorline = true
o.expandtab = true
o.fillchars = { eob = ' ' }
o.guicursor = ''
o.listchars = { extends = '→', lead = '․', nbsp = '␣', precedes = '←', tab = '¬ ' }
-- o.list = true
o.mouse = 'a'
o.number = true
o.numberwidth = 2
o.pumheight = 10
o.relativenumber = true
o.ruler = false
o.scrolloff = 8
o.shiftwidth = 2
o.sidescroll = 8
o.signcolumn = 'yes'
o.smartindent = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.undodir = os.getenv('HOME') .. '/.vim/undodir'
o.undofile = true
o.updatetime = 200
o.wrap = false
