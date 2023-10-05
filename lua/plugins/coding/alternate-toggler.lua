return {
  {
    'rmagatti/alternate-toggler',
    event = 'BufReadPost',
    config = function()
      require('alternate-toggler').setup({
        alternates = {
          ['enable'] = 'disable',
          ['Enable'] = 'Disable',
          ['ENABLE'] = 'DISABLE',
          ['enabled'] = 'disabled',
          ['Enabled'] = 'Disabled',
          ['ENABLED'] = 'DISABLED',
          ['left'] = 'right',
          ['on'] = 'off',
          ['show'] = 'hide',
          ['true'] = 'false',
          ['True'] = 'False',
          ['TRUE'] = 'FALSE',
          ['up'] = 'down',
          ['yes'] = 'no',
          ['Yes'] = 'No',
          ['YES'] = 'NO',
          ['1'] = '0',
          ['=='] = '!=',
          ['==='] = '!==',
        },
      })
      vim.keymap.set(
        'n',
        '<cr>',
        "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>",
        { desc = 'Toggle alternate' }
      )
    end,
  },
}
