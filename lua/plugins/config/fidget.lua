return function()
  local opts = {
    progress = {
      suppress_on_insert = true,
      lsp = {
        progress_ringbuf_size = 10000,
      },
    },
    notification = {
      window = {
        relative = 'editor', -- where to anchor, either "win" or "editor"
        winblend = 0, -- &winblend for the window
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
