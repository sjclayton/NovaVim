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

  -- adapters
  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb',
      args = { '--port', '${port}' },
    },
  }

  -- configurations
  dap.configurations.rust = {
    {
      name = 'Launch file',
      type = 'codelldb',
      request = 'launch',
      -- program = '${workspaceFolder}/target/debug/${workspaceFolderBasename}',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
    },
  }

  dap.configurations.zig = {
    {
      name = 'Launch file',
      type = 'codelldb',
      request = 'launch',
      -- program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
    },
  }
end
