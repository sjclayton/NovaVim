return function()
  local opts = {
    notification = {
      window = {
        relative = 'win', -- where to anchor, either "win" or "editor"
        -- winblend = 0, -- &winblend for the window
        zindex = nil, -- the zindex value for the window
        border = 'none', -- style of border for the fidget window
      },
      view = {
        stack_upwards = false,
      },
    },
  }

  require('fidget').setup(opts)
end
