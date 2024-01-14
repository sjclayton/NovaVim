local Util = require('lazy.core.util')

---@param state boolean?
local function notify(field, state)
  if state == false then
    Util.warn(field .. ' off', { title = 'Toggle' })
  else
    Util.info(field .. ' on', { title = 'Toggle' })
  end
end

local M = {}

-- Key mapping helper
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle_opt(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      ---@diagnostic disable-next-line: no-unknown
      vim.opt_local[option] = values[2]
    else
      ---@diagnostic disable-next-line: no-unknown
      vim.opt_local[option] = values[1]
    end
    return Util.info('Set ' .. option .. ' to ' .. vim.opt_local[option]:get(), { title = 'Option' })
  end
  ---@diagnostic disable-next-line: no-unknown
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      notify(option)
    else
      notify(option, false)
    end
  end
end

local toggle_state = {}
---@param name string Name of the feature to toggle, used as display name for notifications.
---@param cmds table Contains commands required to enable/disable this feature. Expects: { enable=string, disable=string }
---@param default boolean? optional - Whether the feature is considered enabled by default. Default: false if not provided.
---@param silent boolean? optional - Whether to show notifications about toggled commands.
function M.toggle_cmd(name, cmds, default, silent)
  local enable = cmds.enable
  local disable = cmds.disable

  default = default or false

  if not (enable and disable) then
    error("Couldn't toggle " .. name .. ': missing command in cmds table.', 2)
  end

  toggle_state[name] = not toggle_state[name]

  local function enabled()
    vim.cmd(enable)
    if not silent then
      notify(name)
    end
  end
  local function disabled()
    vim.cmd(disable)
    if not silent then
      notify(name, false)
    end
  end

  if not default then
    if toggle_state[name] then
      enabled()
    else
      disabled()
    end
  else
    if toggle_state[name] then
      disabled()
    else
      enabled()
    end
  end
  return toggle_state[name]
end

local nu = { number = true, relativenumber = true }
function M.number()
  if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
    nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    notify('number', false)
  else
    vim.opt_local.number = nu.number
    vim.opt_local.relativenumber = nu.relativenumber
    notify('number')
  end
end

local enabled = true
function M.diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    notify('Diagnostics')
  else
    vim.diagnostic.disable()
    notify('Diagnostics', false)
  end
end

return M
