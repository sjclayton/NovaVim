return {
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup({
        -- list of servers for mason to install
        ensure_installed = {
          'cssls',
          'gopls',
          'html',
          'lua_ls',
          'pyright',
          'tsserver',
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })
    end,
  },
}
