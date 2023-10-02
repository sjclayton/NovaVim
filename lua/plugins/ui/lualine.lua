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
    opts = function()
      return {
        options = {
          icons_enabled = true,
          theme = 'auto',
          globalstatus = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = { 'alpha', 'harpoon', 'markdown.cody_history', 'markdown.cody_prompt', 'TelescopePrompt' },
            winbar = {},
          },
        },
        sections = {
          lualine_b = { 'branch', 'diagnostics' },
          lualine_c = { { 'filetype', icon_only = true }, { 'filename', padding = { left = 0 } } },
          lualine_x = {
            {
              require('nomodoro').status,
              color = function()
                if vim.g.colors_name == 'rose-pine' then
                  return 'Keyword'
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
            {
              'diff',
              symbols = {
                added = icons.git.Add,
                modified = icons.git.Mod,
                removed = icons.git.Remove,
              },
            },
            {
              util.get_lsp_status_str,
              icon = icons.ui.Gear,
              color = { fg = colors.get_palette(mocha).subtext1 },
              on_click = function()
                vim.cmd(':LspInfo')
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
        extensions = { 'lazy' },
      }
    end,
  },
}
