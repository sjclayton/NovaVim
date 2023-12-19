return function()
  local opts = {
    alternates = {
      ['enable'] = 'disable',
      ['Enable'] = 'Disable',
      ['ENABLE'] = 'DISABLE',
      ['enabled'] = 'disabled',
      ['Enabled'] = 'Disabled',
      ['ENABLED'] = 'DISABLED',
      ['left'] = 'right',
      ['top'] = 'bottom',
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
  }

  require('alternate-toggler').setup(opts)
end
