return {
  {
    'metakirby5/codi.vim',
    keys = {
      {
        '<leader>cr',
        function()
          require('core.helpers').toggle('REPL', { enable = 'Codi', disable = 'Codi!' })
        end,
        desc = 'Toggle REPL',
        noremap = true,
      },
    },
    config = function()
        vim.cmd([[let g:codi#virtual_text_prefix = " 󰶻  "]])
    end,
  },
}
