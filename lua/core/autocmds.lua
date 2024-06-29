local function augroup(name)
  return vim.api.nvim_create_augroup('nova_' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed

vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- Highlight on yank

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized

vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Go to last edit location when opening a buffer

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

-- Set line wrap in text filetypes

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap'),
  pattern = { 'gitcommit', 'markdown', '*.txt' },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- Disable colorcolumn in certain filetypes

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('disable_colorcolumn'),
  pattern = {
    'Trouble',
    'checkhealth',
    'help',
    'lazy',
    'lspinfo',
    'markdown',
    'mason',
    'neo-tree',
    'noice',
    'text',
    'qf',
  },
  callback = function()
    vim.opt_local.colorcolumn = ''
  end,
})

-- Close some filetypes with <q>

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'gitsigns.blame',
    'help',
    'lspinfo',
    'man',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Fix conceallevel for json files

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Large file handling (LSP, treesitter and other ft plugins will be disabled)

vim.filetype.add({
  pattern = {
    ['.*'] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= 'bigfile'
            and path
            and vim.fn.getfsize(path) > vim.g.bigfile_size
            and 'bigfile'
          or nil
      end,
    },
  },
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('bigfile'),
  pattern = 'bigfile',
  callback = function(ev)
    vim.schedule(function()
      vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ''
    end)
  end,
})
