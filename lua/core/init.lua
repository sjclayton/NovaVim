local M = {}

require('core.helpers')
require('core.options')
require('core.lazy')

function M.load(name)
  local Util = require('lazy.core.util')
  local function _load(mod)
    Util.try(function()
      require(mod)
    end, {
      msg = 'Failed loading ' .. mod,
      on_error = function(msg)
        local info = require('lazy.core.cache').find(mod)
        if info == nil or (type(info) == 'table' and #info == 0) then
          return
        end
        Util.error(msg)
      end,
    })
  end
  _load('core.' .. name)
  if vim.bo.filetype == 'lazy' then
    -- HACK: NovaVim may have overwritten options of the Lazy UI, so reset this here
    vim.cmd([[do VimResized]])
  end
  local pattern = 'NovaVim' .. name:sub(1, 1):upper() .. name:sub(2)
  vim.api.nvim_exec_autocmds('User', { pattern = pattern, modeline = false })
end

if vim.fn.argc(-1) == 0 then
  -- Defer loading of autocmds and keymaps.
  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('NovaVim', { clear = true }),
    pattern = 'VeryLazy',
    callback = function()
      M.load('autocmds')
      M.load('keymaps')
    end,
  })
else
  -- Load them now so they affect the opened buffers.
  M.load('autocmds')
  M.load('keymaps')
end

-- Set chosen colorscheme here.
vim.cmd.colorscheme('catppuccin')

return M
