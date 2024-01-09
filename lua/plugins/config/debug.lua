local icons = require('core.icons')

return function()
  local dap = require('dap')

  -- set icons/highlights for gutter
  vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

  for name, sign in pairs(icons.dap) do
    sign = type(sign) == 'table' and sign or { sign }
    vim.fn.sign_define(
      'Dap' .. name,
      { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
    )
  end

  dap.adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = '13000',
    executable = {
      command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb',
      args = { '--port', '13000' },
    },
  }
end
