local util = require('core.util')
local icons = require('core.icons')
local colors = require('catppuccin.palettes')

local function ts_status()
  return 'TS'
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      -- 'nvim-telescope/telescope.nvim', -- Switch filetype and git branches
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      vim.o.laststatus = 0
    end,
    config = function()
      vim.o.laststatus = vim.g.lualine_laststatus
      require('lualine').setup({
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
            },
          },
          lualine_c = {
            { 'filetype', icon_only = true },
            { 'filename', padding = { left = 0 } },
          },
          lualine_x = {
            { require('lazy.status').updates, cond = require('lazy.status').has_updates, color = util.fg('Special') },
            {
              require('nomodoro').status,
              color = function()
                if vim.g.colors_name == 'rose-pine' then
                  return util.fg('Keyword')
                elseif vim.g.colors_name == 'catppuccin-mocha' then
                  return 'Keyword'
                elseif vim.g.colors_name == 'catppuccin-macchiato' then
                  return 'Keyword'
                end
              end,
            },
          },
          lualine_y = {
            'diagnostics',
            {
              util.lsp_clients,
              icon = icons.ui.Gear,
              color = { fg = colors.get_palette(mocha).subtext1 },
              on_click = function()
                vim.cmd('LspInfo')
              end,
            },
            {
              ts_status,
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
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { 'neo-tree', 'lazy' },
      })
    end,
  },
}
