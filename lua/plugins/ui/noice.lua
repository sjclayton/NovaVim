return {
  -- lazy.nvim
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      local fn = vim.fn
      local marginTopPercent = 0.48
      local verticalPad = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

      require('noice').setup({
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
          lsp_doc_border = true,
        },
        views = {
          cmdline_popup = {
            position = {
              row = verticalPad,
              col = '50%',
            },
            size = {
              width = 60,
              height = 'auto',
            },
          },
          popupmenu = {
            relative = 'editor',
            position = {
              row = verticalPad + 3,
              col = '50%',
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = 'rounded',
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = 'Normal', FloatBorder = 'NoiceCmdlinePopupBorder' },
            },
          },
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
              },
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = 'msg_show',
              kind = 'emsg',
              find = 'No buffers were deleted',
            },
            opts = { skip = true },
          },
          {
            filter = {
              find = 'hlchunk',
            },
            opts = { skip = true, title = 'lazy.nvim' },
          },
        },
      })
    end,
  },
}
