local M = {}

-- Key mapping helper
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Telescope fallback for non git directory
--
-- Option 1 - Display notification about why command failed (Default)
-- Option 2 - Fallback to using :Telescope find_files instead
function M.project_files()
  local opts = {}
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('notify')('You are not in a git directory') -- this is option #1
    -- require('telescope.builtin').find_files(opts) -- this is option #2
  end
end

local toggle_state = {}

---@param name string
---@param cmds table
--- cmds table expects:
---   enable: string - The command to enable the feature
---   disable: string - The command to disable the feature
--- NOTE: Swap the commands if you enable a feature by default
function M.toggle(name, cmds)
  toggle_state[name] = not toggle_state[name]
  local enable = cmds.enable
  local disable = cmds.disable

  if toggle_state[name] then
    vim.cmd(enable)
    require('notify')(name .. ' enabled', 'info')
  else
    vim.cmd(disable)
    require('notify')(name .. ' disabled', 'info')
  end

  return toggle_state[name]
end

return M
