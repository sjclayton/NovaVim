return {
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        -- List of language servers for mason to automatically install
        ensure_installed = {
          'bashls',
          'cssls',
          'gopls',
          'html',
          'lua_ls',
          'pylsp',
          'tsserver',
        },
        -- Auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })
    end,
  },
}
