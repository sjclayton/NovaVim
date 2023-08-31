-- Ensure leader key is mapped before anything else happens.
vim.g.mapleader = ' '

require 'core.lazy'
require 'core.options'
require 'core.keymap'

vim.cmd.colorscheme 'catppuccin'
