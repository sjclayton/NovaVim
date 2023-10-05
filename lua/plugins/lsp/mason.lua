return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = {
      { '<leader>cm', '<CMD>Mason<cr>', desc = 'Open Mason', noremap = true },
    },
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
