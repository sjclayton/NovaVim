return {
  {
    'rmagatti/alternate-toggler',
    keys = {
      {
        '<CR>',
        "<cmd>lua require('alternate-toggler').toggleAlternate()<cr>",
        desc = 'Toggle alternate',
        noremap = true,
      },
    },
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
    end,
  },
}
