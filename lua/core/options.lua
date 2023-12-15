local g = vim.g
local o = vim.opt

g.mapleader = ' '
g.maplocalleader = '\\'
g.markdown_recommended_style = 0

g.zig_fmt_autosave = 0

o.backup = false
o.clipboard = 'unnamedplus'
o.colorcolumn = '120'
o.conceallevel = 3
o.confirm = true
o.cursorline = true
o.expandtab = true
o.fillchars = { eob = ' ' }
o.foldexpr = "v:lua.vim.require'core.util'.foldexpr()"
o.foldlevel = 99
o.foldmethod = 'expr'
o.foldtext = "v:lua.require'core.util'.foldtext()"
-- TODO: Uncomment this when conform.nvim is setup and the function has been added to core.util
-- o.formatexpr = "v:lua.require'core.util'.formatexpr()"
o.guicursor = ''
o.laststatus = 3
o.lazyredraw = false
o.listchars = { extends = '→', lead = '․', nbsp = '␣', precedes = '←', tab = '¬ ' }
o.mouse = 'a'
o.mousemodel = 'extend'
o.mousemoveevent = true
o.number = true
o.numberwidth = 2
o.pumheight = 10
o.relativenumber = true
o.ruler = false
o.scrolloff = 8
o.shiftwidth = 4
o.shortmess:append('IWs')
o.sidescroll = 8
o.signcolumn = 'yes'
o.smartcase = true
o.smartindent = true
o.smoothscroll = true
o.splitbelow = true
o.splitright = true
o.statuscolumn = [[%!v:lua.require'core.util'.statuscolumn()]]
o.swapfile = false
o.timeout = true
o.timeoutlen = 300
o.tabstop = 4
o.termguicolors = true
o.undodir = os.getenv('HOME') .. '/.vim/undodir'
o.undofile = true
o.updatetime = 500
o.wrap = false
