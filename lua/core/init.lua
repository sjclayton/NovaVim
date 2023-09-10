local M = {}

local Util = require('core.util')

require('core.helpers')
require('core.options')
require('core.lazy')

if vim.fn.argc(-1) == 0 then
  -- Defer loading of autocmds and keymaps.
  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('NovaVim', { clear = true }),
    pattern = 'VeryLazy',
    callback = function()
      Util.load('autocmds')
      Util.load('keymaps')
    end,
  })
else
  -- Load them now so they affect the opened buffers.
  Util.load('autocmds')
  Util.load('keymaps')
end

Util.lazy_notify()

-- NOTE: Set chosen the colorscheme on the line below.
-- Make sure the plugin spec for your colorscheme has a priority of 1000 or higher.
M.Colorscheme = 'catppuccin'
-- NOTE: Define any specific variant of your chosen colorscheme in its corresponding plugin spec or set it directly here.
--@type[string]
M.Colorscheme_variant = ''

if Util.has(M.Colorscheme) then
  require(M.Colorscheme)
  if M.Colorscheme_variant ~= '' or nil then
    vim.cmd.colorscheme(M.Colorscheme_variant)
  else
    vim.cmd.colorscheme(M.Colorscheme)
  end
elseif Util.has('catppuccin') then
  require('catppuccin')
  vim.cmd.colorscheme('catppuccin')
elseif Util.has('tokyonight.nvim') then
  require('tokyonight')
  vim.cmd.colorscheme('tokyonight')
else
  require('notify')('Could not load your colorscheme!', 'error')
  vim.cmd.colorscheme('habamax')
end

return M
