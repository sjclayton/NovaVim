-- Extend package.path to include luarocks path for lua 5.1 (necessary for image.nvim)
-- See https://github.com/3rd/image.nvim for setup instructions.
-- NOTE: Must be using kitty as a terminal for image support to work, and have the appropriate options set
-- for tmux if you're using it. You may remove this if not using image.nvim!
package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?/init.lua;'
package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?.lua;'

local util = require('core.util')

require('core.options')
require('core.lazy')
require('core.config')

if vim.fn.argc(-1) == 0 then
  -- Defer loading of autocmds and keymaps.
  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('NovaVim', { clear = true }),
    pattern = 'VeryLazy',
    callback = function()
      util.load('autocmds')
      util.load('keymaps')
    end,
  })
else
  -- Load them now so they affect the opened buffers.
  util.load('autocmds')
  util.load('keymaps')
end

util.lazy_notify()

if util.has(Primary_Colorscheme) then
  require(Primary_Colorscheme)
  if Colorscheme_Variant ~= '' or nil then
    vim.cmd.colorscheme(Colorscheme_Variant)
  else
    vim.cmd.colorscheme(Primary_Colorscheme)
  end
elseif util.has('rose-pine') then
  require('rose-pine')
  vim.cmd.colorscheme('rose-pine')
elseif util.has('catppuccin') then
  require('catppuccin')
  vim.cmd.colorscheme('catppuccin')
else
  pcall(require('notify')('Could not load your colorscheme or a preferred fallback', 'error'))
  vim.cmd.colorscheme('habamax')
end
