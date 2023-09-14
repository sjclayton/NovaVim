return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = function()
      -- import mason
      local mason = require('mason')

      -- configure mason
      mason.setup({
        ui = {
          border = 'rounded',
        },
      })
    end,
  },
}
