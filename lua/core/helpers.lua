---@param state boolean?
local function notify(field, state)
  if state == false then
    LazyVim.warn(field .. ' off', { title = 'Toggle' })
  else
    LazyVim.info(field .. ' on', { title = 'Toggle' })
  end
end

local M = {}

-- Helper for keymaps
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Helper for dynamically setting highlights on based on colorscheme
---@param default table|string?
---@param primary table|string?
---@param secondary table|string?
function M.theme_hl(default, primary, secondary)
  if vim.g.colors_name == Primary_Colorscheme then
    return primary or default
  elseif vim.g.colors_name == Secondary_Colorscheme then
    return secondary or default
  else
    return default or nil
  end
end

local toggle_state = {}
-- Helper for enabling/disabling or toggling commands
---@param name string Name of the feature to toggle, used as display name for notifications.
---@param cmds table Contains commands required to enable/disable or toggle this feature.
---Expects: { enable=string, disable=string } or { toggle=string }
---@param default boolean? optional - Whether the feature is considered enabled by default. Default: false if not provided.
---@param silent boolean? optional - Whether to show notifications about toggled features.
function M.toggle_cmd(name, cmds, default, silent)
  local enable = cmds.enable
  local disable = cmds.disable
  local toggle = cmds.toggle

  default = default or false

  if not (enable and disable or toggle) then
    error("Couldn't toggle " .. name .. ': missing command in cmds table.', 2)
  end

  toggle_state[name] = not toggle_state[name]

  local function enabler()
    if enable then
      vim.cmd(enable)
    else
      vim.cmd(toggle)
    end
    if not silent then
      notify(name)
    end
  end

  local function disabler()
    if disable then
      vim.cmd(disable)
    else
      vim.cmd(toggle)
    end
    if not silent then
      notify(name, false)
    end
  end

  if not default then
    if toggle_state[name] then
      enabler()
    else
      disabler()
    end
  else
    if toggle_state[name] then
      disabler()
    else
      enabler()
    end
  end

  return toggle_state[name]
end

local enabled = true
function M.diagnostics()
  if vim.diagnostic.is_enabled then
    enabled = vim.diagnostic.is_enabled()
  end

  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    notify('Diagnostics')
  else
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    notify('Diagnostics', false)
  end
end

return M
