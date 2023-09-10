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

return M
