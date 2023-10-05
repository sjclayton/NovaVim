return {
  {
    'lukas-reineke/headlines.nvim',
    ft = 'markdown',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {
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
    },
  },
}
