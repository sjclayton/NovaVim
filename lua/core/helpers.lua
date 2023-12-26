local M = {}

-- Key mapping helper
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local toggle_state = {}

---@param name string
---@param cmds table
--- cmds table expects:
---   enable: string - The command to enable the feature
---   disable: string - The command to disable the feature
--- NOTE: Toggle assumes feature(command) is disabled by default.
--- If that isn't the case swap the commands given in the cmds table if feature(command) is enabled by default.
function M.toggle(name, cmds)
  local enable = cmds.enable
  local disable = cmds.disable

  if not (enable and disable) then
    error("Couldn't toggle " .. name .. ': missing command in cmds table.', 0)
  end

  toggle_state[name] = not toggle_state[name]

  if toggle_state[name] then
    vim.cmd(enable)
    pcall(require('notify')(name, 'info', { title = 'Toggled' }))
  else
    vim.cmd(disable)
    pcall(require('notify')(name, 'info', { title = 'Toggled' }))
  end

  return toggle_state[name]
end

return M
