return {
  'mbbill/undotree',
  keys = {
    { '<F5>', '<cmd>UndotreeToggle<cr>', desc = 'Toggle UndoTree' },
  },
  config = function()
    vim.g.undotree_SplitWidth = 35
  end,
}
