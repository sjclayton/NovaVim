--
-- Initial setup and configuration of lazy.nvim
-- DO NOT modify unless you know what you're doing.
--

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim...')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable', -- latest stable release
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local util = require('core.util')

util.lazy_file()

require('lazy').setup({
  spec = {
    -- lock lazy.nvim to latest stable version
    { 'folke/lazy.nvim', version = '*' },
    -- import LazyVim utility functions without it's plugins
    -- WARN: Do NOT try import LazyVim's default plugins or extras, NovaVim is configured
    -- fundamentally differently, things will break!
    { 'LazyVim/LazyVim', priority = 10000, lazy = false, version = '*' },
    -- import NovaVim plugins
    { import = 'plugins' },
  },
  defaults = {
    lazy = true, -- lazy load everything
    version = false,
  },
  install = { colorscheme = { 'rose-pine', 'habamax' } },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = true, -- get a notification when new updates are found
    frequency = 43200, -- check for updates every 12 hours
  },
  change_detection = { enabled = false, notify = false },
  ui = {
    backdrop = 100,
    border = 'rounded',
  },
  performance = {
    cache = { enabled = true },
    rtp = {
      paths = {},
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
        'tutor',
        'zipPlugin',
      },
    },
  },
})
