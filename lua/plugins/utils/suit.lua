return {
  'doums/suit.nvim',
  -- event = 'VeryLazy',
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require('lazy').load({ plugins = { 'suit.nvim' } })
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require('lazy').load({ plugins = { 'suit.nvim' } })
      return vim.ui.input(...)
    end
  end,
  config = function()
    require('suit').setup({
      input = {
        -- default prompt value
        default_prompt = 'Input: ',
        -- border of the window (see `:h nvim_open_win`)
        border = 'rounded',
        -- highlight group for the input UI window
        -- links to NormalFloat
        hl_win = 'NormalFloat',
        -- highlight group for the prompt text
        -- links to NormalFloat
        hl_prompt = 'NormalFloat',
        -- highlight group for the window border
        -- links to FloatBorder
        hl_border = 'FloatBorder',
        -- input width (in addition to the default value)
        width = 20,
        -- override arguments passed to `nvim_open_win` (see `:h nvim_open_win`)
        nvim_float_api = nil,
      },
      select = {
        -- default prompt value
        default_prompt = 'Select one of: ',
        -- border of the window (see `:h nvim_open_win`)
        border = 'rounded',
        -- highlight group for the select UI window
        -- links to NormalFloat
        hl_win = 'NormalFloat',
        -- highlight group for the prompt text
        -- links to NormalFloat
        hl_prompt = 'NormalFloat',
        -- highlight group for the selected item
        -- links to PmenuSel
        hl_sel = 'PmenuSel',
        -- highlight group for the window border
        -- links to FloatBorder
        hl_border = 'FloatBorder',
        -- override arguments passed to `nvim_open_win` (see `:h nvim_open_win`)
        nvim_float_api = nil,
      },
    })
  end,
}
