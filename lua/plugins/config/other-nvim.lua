return function()
  require('other-nvim').setup({
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
    },
    style = {
      border = 'rounded',
    },
  })
end
