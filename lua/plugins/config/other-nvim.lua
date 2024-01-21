return function()
  local opts = {
    mappings = {
      -- Golang
      {
        pattern = '(.*)/(.*).go',
        target = {
          { context = 'test', target = '%1/%2_test.go' },
        },
      },
      {
        pattern = '(.*)/(.*)_test.go',
        target = {
          { context = 'implementation', target = '%1/%2.go' },
        },
      },
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
