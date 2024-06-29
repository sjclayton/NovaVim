-- Extend package.path to include luarocks path for lua 5.1 (necessary for image.nvim)
-- See https://github.com/3rd/image.nvim for setup instructions.
-- NOTE: Must be using kitty as a terminal for image support to work, and have the appropriate options set
-- for tmux if you're using it. You may remove these two lines if you're not using image.nvim.
package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?/init.lua;'
package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?.lua;'

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('core.lazy')
require('core.config')

local util = require('core.util')
_G.LazyVim = require('lazyvim.util')

util.load('options')

local lazy_autocmds = vim.fn.argc(-1) == 0
if not lazy_autocmds then
  util.load('autocmds')
end

local group = vim.api.nvim_create_augroup('NovaVim', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'VeryLazy',
  callback = function()
    if lazy_autocmds then
      util.load('autocmds')
    end
    util.load('keymaps')

    LazyVim.root.setup()

    vim.api.nvim_create_user_command('LazyHealth', function()
      vim.cmd([[Lazy! load all]])
      vim.cmd([[checkhealth]])
    end, { desc = 'Load all plugins and run :checkhealth' })
  end,
})

LazyVim.lazy_notify()

if LazyVim.has(Primary_Colorscheme) then
  require(Primary_Colorscheme)
  if not Colorscheme_Variant or Colorscheme_Variant == '' then
    vim.cmd.colorscheme(Primary_Colorscheme)
  else
    vim.cmd.colorscheme(Colorscheme_Variant)
  end
elseif LazyVim.has('rose-pine') then
  require('rose-pine')
  vim.cmd.colorscheme('rose-pine')
elseif LazyVim.has('catppuccin') then
  require('catppuccin')
  vim.cmd.colorscheme('catppuccin')
else
  pcall(require('notify')('Could not load your colorscheme or a preferred fallback', 'error'))
  vim.cmd.colorscheme('habamax')
end
