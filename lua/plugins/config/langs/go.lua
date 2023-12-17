return function()
  local opts = {
    lsp_cfg = false,
    lsp_inlay_hints = {
      enable = false,
    },
    diagnostic = false,
  }
  require('go').setup(opts)
end
