local function augroup(name)
  return vim.api.nvim_create_augroup('nova_' .. name, { clear = true })
end

-- Go to last edit location when opening a buffer.

vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function()
    local exclude = { 'gitcommit' }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
