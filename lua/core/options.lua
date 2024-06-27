local g = vim.g
local o = vim.opt

vim.g.root_spec = { 'lsp', { '.git', 'lua' }, 'cwd' }

g.markdown_recommended_style = 0

o.backup = false
o.clipboard = 'unnamedplus'
o.colorcolumn = '120'
o.completeopt = 'menu,preview,noinsert'
o.conceallevel = 2
o.confirm = true
o.cursorline = true
o.expandtab = true
o.fillchars = { foldopen = '', foldclose = '', fold = ' ', foldsep = ' ', diff = '╱', eob = ' ' }
o.foldlevel = 99
o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
o.guicursor = ''
o.ignorecase = true
o.laststatus = 3
o.linebreak = true
o.listchars = { extends = '→', nbsp = '␣', precedes = '←', tab = '¬ ' }
o.mouse = 'a'
o.mousemodel = 'extend'
o.mousemoveevent = true
o.number = true
o.numberwidth = 2
o.pumheight = 10
o.relativenumber = true
o.ruler = false
o.scrolloff = 10
o.shiftwidth = 4
o.shortmess:append('IWs')
o.showmode = false
o.sidescroll = 10
o.signcolumn = 'yes'
o.smartcase = true
o.smartindent = true
o.smoothscroll = true
o.spelllang = 'en'
o.splitbelow = true
o.splitright = true
o.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
o.swapfile = false
o.tabstop = 4
o.termguicolors = true
o.timeout = true
o.timeoutlen = 300
o.undodir = { os.getenv('HOME') .. '/.vim/undodir' }
o.undofile = true
o.undolevels = 10000
o.updatetime = 200
o.wrap = false

if vim.fn.has('nvim-0.10') == 1 then
  o.smoothscroll = true
  o.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  o.foldmethod = 'expr'
  o.foldtext = ''
else
  o.foldmethod = 'indent'
  o.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end
