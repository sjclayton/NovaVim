return function ()
vim.keymap.set('i', '<A-b>', function()
  return vim.fn['codeium#CycleCompletions'](-1)
end, { desc = 'Cycle Previous Codeium Completion', expr = true })
vim.keymap.set('i', '<A-f>', function()
  return vim.fn['codeium#CycleCompletions'](1)
end, { desc = 'Cycle Next Codeium Completion', expr = true })
vim.keymap.set('i', '<A-,>', function()
  return vim.fn['codeium#Accept']()
end, { desc = 'Accept Codeium Completion', expr = true })
vim.keymap.set('i', '<A-;>', function()
  return vim.fn['codeium#Clear']()
end, { desc = 'Clear Codeium Completion', expr = true })

if vim.g.codeium_manual then
  vim.keymap.set('i', '<A-.>', function()
    return vim.fn['codeium#Complete']()
  end, { desc = 'Request Codeium Completion', expr = true })
end
end
