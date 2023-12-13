return {
  'sourcegraph/sg.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>cd',
      function()
        vim.cmd(':CodyToggle')
        vim.cmd(':vertical resize +25N')
      end,
      desc = 'Toggle Cody chat',
      noremap = true,
    },
    {
      '<leader>cq',
      function()
        vim.ui.input({ prompt = 'What is your question:' }, function(input)
          if input ~= nil or not '' then
            vim.cmd("'<,'>:CodyAsk " .. input)
            vim.cmd(':vertical resize +25N')
          end
        end)
      end,
      mode = 'v',
      desc = 'Ask Cody about the current selection',
      noremap = true,
    },
  },
}
