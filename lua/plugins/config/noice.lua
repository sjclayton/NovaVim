return function()
  local opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      progress = {
        enabled = false,
      },
    },
    presets = {
      command_palette = true,
      lsp_doc_border = true,
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
            { find = '%d fewer lines' },
            { find = '%d more lines' },
            { find = '%d lines [<>]ed' },
            { find = '%d lines [changed|indented|moved|yanked]' },
          },
        },
        opts = { skip = true },
      },
      {
        filter = {
          any = {
            { find = 'deadcolumn' },
          },
        },
        opts = { skip = true, title = 'lazy.nvim' },
      },
    },
  }

  require('noice').setup(opts)
end
