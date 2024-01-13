return function()
  local cc_color = ''
  if vim.g.colors_name == 'rose-pine' then
    cc_color = '#6e6a86'
  elseif vim.g.colors_name == 'catppuccin-mocha' then
    cc_color = '#585b70'
  elseif vim.g.colors_name == 'catppuccin-macchiato' then
    cc_color = '#5b6078'
  else
    cc_color = '#ed8796'
  end

  local opts = {
    scope = 'buffer',
    ---@type string[]|fun(mode: string): boolean
    modes = function(mode)
      return mode:find('^[ictRss\x13]') ~= nil
    end,
    blending = {
      threshold = 1.0,
      colorcode = '#000000',
      hlgroup = { 'Normal', 'bg' },
    },
    warning = {
      alpha = 0.4,
      offset = 0,
      colorcode = cc_color,
      -- hlgroup = { 'Normal', 'bg' },
    },
    extra = {
      follow_tw = nil,
    },
  }

  require('deadcolumn').setup(opts)

  vim.api.nvim_create_augroup('reload_deadcolumn', { clear = true })
  vim.api.nvim_create_autocmd('Colorscheme', {
    group = 'reload_deadcolumn',
    callback = function()
      vim.cmd('Lazy reload deadcolumn.nvim')
    end,
  })
end
