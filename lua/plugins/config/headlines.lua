return function()
  local opts = {
    markdown = {
      headline_highlights = {
        'Headline1',
        'Headline2',
        'Headline3',
        'Headline4',
        'Headline5',
        'Headline6',
      },
      codeblock_highlight = 'CodeBlock',
      dash_highlight = 'Dash',
      quote_highlight = 'Quote',
    },
  }
  vim.schedule(function()
    require('headlines').setup(opts)
    require('headlines').refresh()
  end)
end
