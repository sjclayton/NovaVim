return function ()
  local opts = {
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
    }

    require('suit').setup(opts)
  end
