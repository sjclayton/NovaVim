return function()
  local util = require('core.util')
  local icons = require('core.icons')
  local colors = require('catppuccin.palettes')

  local custom_components = {
    -- Override 'encoding': Don't display if encoding is UTF-8.
    encoding = function()
      local ret, _ = (vim.bo.fenc or vim.go.enc):gsub('^utf%-8$', '')
      return ret
    end,
    -- Override 'fileformat': Don't display if &ff is unix.
    fileformat = function()
      local ret, _ = vim.bo.fileformat:gsub('^unix$', '')
      return ret
    end,
    modified = function()
      if vim.bo.modified == true then
        return icons.ui.Modified
      else
        return ''
      end
    end,
    is_writable = function()
      if vim.bo.modifiable == false or vim.bo.readonly == true then
        return icons.ui.Lock
      else
        return ''
      end
    end,
  }
  _G.lualine_components = custom_components

  vim.o.laststatus = vim.g.lualine_laststatus

  local opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      globalstatus = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { 'alpha', 'harpoon', 'TelescopePrompt' },
        winbar = {},
      },
    },
    sections = {
      lualine_b = {
        'branch',
        {
          'diff',
          symbols = {
            added = icons.git.Add,
            modified = icons.git.Mod,
            removed = icons.git.Remove,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      },
      lualine_c = {
        { 'filetype', icon_only = true },
        {
          'filename',
          path = 1,
          file_status = false,
          cond = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
          end,
          padding = { left = 0, right = 1 },
        },
        { custom_components.modified, padding = { right = 1 }, color = 'String' },
        { custom_components.is_writable, padding = { left = 0 }, color = 'Error' },
      },
      lualine_x = {
        {
          function()
            return require('noice').api.status.command.get()
          end,
          cond = function()
            return package.loaded['noice'] and require('noice').api.status.command.has()
          end,
          color = util.fg('Tag'),
        },
        {
          function()
            return require('noice').api.status.mode.get()
          end,
          cond = function()
            return package.loaded['noice'] and require('noice').api.status.mode.has()
          end,
          color = util.fg('Macro'),
        },
        { require('lazy.status').updates, cond = require('lazy.status').has_updates, color = util.fg('Special') },
        {
          function()
            if package.loaded['nomodoro'] then
              return require('nomodoro').status()
            else
              return ''
            end
          end,
          color = function()
            if vim.g.colors_name == 'rose-pine' then
              return util.fg('Keyword')
            elseif vim.g.colors_name == 'catppuccin-mocha' then
              return 'Keyword'
            elseif vim.g.colors_name == 'catppuccin-macchiato' then
              return 'Keyword'
            else
              return nil
            end
          end,
        },
      },
      lualine_y = {
        'diagnostics',
        {
          util.lsp_client_names,
          icon = icons.ui.Gear,
          color = { fg = colors.get_palette(mocha).subtext1 },
          on_click = function()
            vim.cmd('LspInfo')
          end,
        },
        {
          function()
            return 'TS'
          end,
          cond = util.treesitter_available,
          icon = icons.ui.Braces,
          color = function()
            if vim.g.colors_name == 'rose-pine' then
              return { fg = '#f6c177' }
            elseif vim.g.colors_name == 'catppuccin-mocha' then
              return { fg = '#a6e3a1' }
            elseif vim.g.colors_name == 'catppuccin-macchiato' then
              return { fg = '#a6da95' }
            else
              return nil
            end
          end,
        },
      },
      lualine_z = {
        'location',
        { custom_components.encoding, padding = { left = 0, right = 1 } },
        { custom_components.fileformat, padding = { left = 0, right = 1 } },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { 'lazy', 'mason', 'neo-tree', 'trouble' },
  }

  require('lualine').setup(opts)
end
