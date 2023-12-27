return function()
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local cmp = require('cmp')
  local compare = require('cmp.config.compare')
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

    preselect = cmp.PreselectMode.None,

    --- @diagnostic disable-next-line : missing-fields
    completion = {
      completeopt = 'menu,menuone,preview,noselect',
    },

    -- configure how nvim-cmp interacts with snippet engine
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = {
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      }),
      ['<C-f>'] = cmp.mapping(function(fallback)
        if luasnip.choice_active() then
          require('luasnip').change_choice(1)
        elseif cmp.visible() then
          cmp.scroll_docs(4)
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<C-d>'] = cmp.mapping(function(fallback)
        if luasnip.choice_active() then
          require('luasnip').change_choice(-1)
        elseif cmp.visible() then
          cmp.scroll_docs(-4)
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          else
            cmp.select_next_item()
          end
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          end
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),

      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),

      ['<C-k>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),

      ['<C-j>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
    },

    -- sources for autocompletion
    sources = cmp.config.sources({
      { name = 'crates' }, -- Rust crates
      { name = 'codeium', keyword_length = 3 }, -- Codeium AI
      { name = 'nvim_lsp', keyword_length = 3 }, -- LSP
      { name = 'luasnip', keyword_length = 2 }, -- Snippets
      { name = 'path' }, -- File system paths
      { name = 'buffer', keyword_length = 5 }, -- Text within current buffer
      { name = 'calc' }, -- Calculator
    }),

    ---@diagnostic disable-next-line: missing-fields
    sorting = {
      comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        compare.recently_used,
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find('^_+')
          local _, entry2_under = entry2.completion_item.label:find('^_+')
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,
        compare.kind,
        compare.length,
        compare.order,
      },
    },

    window = {
      documentation = cmp.config.window.bordered({ winhighlight = 'Normal:CmpPmenu' }),
      completion = cmp.config.window.bordered({
        winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
      }),
      col_offset = -3,
      side_padding = 0,
    },

    -- configure lspkind for vs-code like pictograms in completion menu
    --- @diagnostic disable-next-line : missing-fields
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({
          mode = 'symbol',
          menu = {
            codeium = '[AI]',
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            calc = '[Calc]',
            buffer = '[Buffer]',
            path = '[Path]',
          },
          maxwidth = 50,
          ellipsis_char = '...',
          symbol_map = { Codeium = '' },
        })(entry, vim_item)

        if vim.tbl_contains({ 'path' }, entry.source.name) then
          local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
          if icon then
            vim_item.kind = icon .. ' '
            vim_item.kind_hl_group = hl_group
            return vim_item
          end
        end

        -- HACK: Get rid of the second column in kind.menu because it's annoying af
        kind.menu = string.sub(kind.menu, 1, string.find(kind.menu, ']'))
        kind.kind = kind.kind .. ' '

        local custom_source_icon = {
          calc = '󰃬 ',
        }

        if entry.source.name == 'calc' then
          kind.kind = custom_source_icon.calc
        end
        return kind
      end,
    },
  })
end
