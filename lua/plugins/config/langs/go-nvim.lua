return function()
  local opts = {
    lsp_cfg = false,
    lsp_gofumpt = false,
    lsp_on_attach = false,
    lsp_inlay_hints = {
      enable = false,
    },
    diagnostic = false,
    lsp_document_formatting = false,
  }
  require('go').setup(opts)
end
