local function augroup(name)
  return vim.api.nvim_create_augroup('nova_' .. name, { clear = true })
end

-- Highlight on yank

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Go to last edit location when opening a buffer.

vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].nova_last_loc then
      return
    end
    vim.b[buf].nova_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '.')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Set line wrap in text filetypes.

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'gitcommit', 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- When there is no buffer left show the Alpha dashboard
-- requires "famiu/bufdelete.nvim" and "goolord/alpha-nvim"

vim.api.nvim_create_autocmd('User', {
  pattern = 'BDeletePost*',
  group = augroup('alpha_on_empty'),
  callback = function(event)
    local fallback_name = vim.api.nvim_buf_get_name(event.buf)
    local fallback_ft = vim.api.nvim_get_option_value('filetype', { buf = event.buf })
    local fallback_on_empty = fallback_name == '' and fallback_ft == ''

    if fallback_on_empty then
      -- require("neo-tree").close_all()
      vim.api.nvim_command('Alpha')
      vim.api.nvim_command(event.buf .. 'bwipeout')
    end
  end,
})

-- HACK: Workaround to fix annoying buggy Telescope behaviour of being put into insert mode after closing.

vim.api.nvim_create_autocmd('WinLeave', {
  group = augroup('telescope_leave'),
  callback = function()
    if vim.bo.ft == 'TelescopePrompt' and vim.fn.mode() == 'i' then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'i', false)
    end
  end,
})
