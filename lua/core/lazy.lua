local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup('plugins', {
  defaults = {
    lazy = false,
    version = false,
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = true, -- get a notification when new updates are found
    frequency = 10800, -- check for updates every 3 hours
  },
  ui = {
    border = 'rounded',
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'tarPlugin',
        'tohtml',
        'zipPlugin',
      },
    },
  },
})
