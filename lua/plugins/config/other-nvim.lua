return function()
  local opts = {
    mappings = {
      'golang',
      -- Lua
      -- Jump to plugins/init.lua from any plugin config file
      {
        pattern = '/lua/plugins/config/.*.lua$',
        target = '/lua/plugins/init.lua',
      },
    },
    style = {
      border = 'rounded',
    },
  }
  require('other-nvim').setup(opts)
end
