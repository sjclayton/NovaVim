require('core.helpers')
require('core.options')
require('core.lazy')

if vim.fn.argc(-1) == 0 then
  -- Defer loading of autocmds and keymaps.
  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('NovaVim', { clear = true }),
    pattern = 'VeryLazy',
    callback = function()
      require('core.autocmds')
      require('core.keymaps')
    end,
  })
else
  -- Load them now so they affect the opened buffers.
  require('core.autocmds')
  require('core.keymaps')
end

-- Set chosen colorscheme here.
vim.cmd.colorscheme('catppuccin')
