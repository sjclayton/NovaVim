local M = {}

-- Extend package.path to include luarocks path for lua 5.1 (necessary for image.nvim)
-- See https://github.com/3rd/image.nvim for setup instructions.
-- NOTE: Must be using kitty as a terminal for image support to work, and have the appropriate options set
-- for tmux if you're using it. You may remove this if not using image.nvim!
package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?/init.lua;'
package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?.lua;'

local util = require('core.util')

require('core.options')
require('core.lazy')
require('core.helpers')

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

-- NOTE: Set your chosen colorscheme on the line below.
-- Make sure the plugin spec for your colorscheme has a priority of 1000 or higher.
M.Colorscheme = 'rose-pine'
-- NOTE: Define any specific variant of your chosen colorscheme in its corresponding plugin spec or
-- set it directly on the line below.
M.Colorscheme_variant = 'rose-pine-moon'

if util.has(M.Colorscheme) then
  require(M.Colorscheme)
  if M.Colorscheme_variant ~= '' or nil then
    vim.cmd.colorscheme(M.Colorscheme_variant)
  else
    vim.cmd.colorscheme(M.Colorscheme)
  end
elseif util.has('catppuccin') then
  require('catppuccin')
  vim.cmd.colorscheme('catppuccin')
elseif util.has('rose-pine') then
  require('rose-pine')
  vim.cmd.colorscheme('rose-pine')
else
  pcall(require('notify')('Could not load your colorscheme or a preferred fallback', 'error'))
  vim.cmd.colorscheme('default')
end

return M
