return function()
  local icons = require('core.icons')
  local theme_hl = require('core.helpers').theme_hl
  local util = require('core.util')

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
        LazyVim.lualine.root_dir(),
        { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
        {
          LazyVim.lualine.pretty_path({ readonly_icon = '' }),
          padding = { left = 0, right = 1 },
        },
        {
          custom_components.modified,
          padding = { right = 1 },
          color = function()
            local fg = theme_hl(LazyVim.ui.fg('String'))
            if fg ~= nil then
              return fg
            end
          end,
        },
        {
          custom_components.is_writable,
          padding = { left = 0 },
          color = function()
            local fg = theme_hl(LazyVim.ui.fg('Error'))
            if fg ~= nil then
              return fg
            end
          end,
        },
      },
      lualine_x = {
        {
          function()
            return require('noice').api.status.command.get()
          end,
          cond = function()
            return package.loaded['noice'] and require('noice').api.status.command.has()
          end,
          color = LazyVim.ui.fg('Tag'),
        },
        {
          function()
            return require('noice').api.status.mode.get()
          end,
          cond = function()
            return package.loaded['noice'] and require('noice').api.status.mode.has()
          end,
          color = LazyVim.ui.fg('Macro'),
        },
        { require('lazy.status').updates, cond = require('lazy.status').has_updates, color = LazyVim.ui.fg('Special') },
        {
          function()
            if package.loaded['nomodoro'] then
              return require('nomodoro').status()
            else
              return ''
            end
          end,
          color = function()
            local fg = theme_hl(LazyVim.ui.fg('Keyword'))
            if fg ~= nil then
              return fg
            end
          end,
        },
      },
      lualine_y = {
        'diagnostics',
        {
          util.lsp_client_names,
          icon = icons.ui.Gear,
          color = function()
            local fg = theme_hl(LazyVim.ui.fg('ModeMsg'))
            if fg ~= nil then
              return fg
            end
          end,
        },
        {
          function()
            return 'TS'
          end,
          cond = util.treesitter_available,
          icon = icons.ui.Braces,
          color = function()
            local fg = theme_hl(LazyVim.ui.fg('String'))
            if fg ~= nil then
              return fg
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
    extensions = { 'lazy', 'mason', 'neo-tree', 'nvim-dap-ui', 'toggleterm', 'trouble' },
  }

  require('lualine').setup(opts)
end
