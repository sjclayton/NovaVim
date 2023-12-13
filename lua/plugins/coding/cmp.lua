return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-calc', -- perform calculations in-line
      'hrsh7th/cmp-buffer', -- source for text in buffer
      'hrsh7th/cmp-path', -- source for file system paths
      'L3MON4D3/LuaSnip', -- snippet engine
      'saadparwaiz1/cmp_luasnip', -- for autocompletion
      'rafamadriz/friendly-snippets', -- useful snippets
      'onsails/lspkind.nvim', -- vs-code like pictograms
    },
    config = function()
      local cmp = require('cmp')

      local luasnip = require('luasnip')

      local lspkind = require('lspkind')

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require('luasnip.loaders.from_vscode').lazy_load()

      --- @diagnostic disable-next-line : missing-fields
      cmp.setup({
        --- @diagnostic disable-next-line : missing-fields
        performance = {
          debounce = 150,
        },
        --- @diagnostic disable-next-line : missing-fields
        completion = {
          completeopt = 'menuone,preview,noselect',
        },
        -- configure how nvim-cmp interacts with snippet engine
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
          ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
          ['<C-e>'] = cmp.mapping.abort(), -- close completion window
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = 'nvim_lsp' }, -- LSP
          { name = 'luasnip' }, -- snippets
          { name = 'calc' }, -- calculator
          { name = 'buffer' }, -- text within current buffer
          { name = 'path' }, -- file system paths
        }),
        window = {
          documentation = cmp.config.window.bordered({ winhighlight = 'Normal:CmpPmenu' }),
          completion = cmp.config.window.bordered({
            winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
          }),
        },
        -- configure lspkind for vs-code like pictograms in completion menu
        --- @diagnostic disable-next-line : missing-fields
        formatting = {
          format = lspkind.cmp_format({
            menu = {},
            maxwidth = 50,
            ellipsis_char = '...',
          }),
        },
      })
    end,
  },
}
