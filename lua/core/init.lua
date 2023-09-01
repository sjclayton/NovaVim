require('core.options')
require('core.lazy')

if vim.fn.argc(-1) == 0 then
  -- autocmds and keymaps can wait to load
  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('NovaVim', { clear = true }),
    pattern = 'VeryLazy',
    callback = function()
      require('core.autocmds')
      require('core.keymaps')
    end,
  })
else
  -- load them now so they affect the opened buffers
  require('core.autocmds')
  require('core.keymaps')
end

vim.cmd.colorscheme('catppuccin')
