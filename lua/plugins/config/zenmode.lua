return function()
  local opts = {
    zindex = 20,
    window = {
      backdrop = 0.90,
      -- width = 0.75,
      width = 0.80,
    },
    plugins = {
      options = {
        laststatus = 0,
      },
      gitsigns = { enabled = true },
      tmux = { enabled = true },
      kitty = {
        enabled = true,
        font = '+2', -- font size increment
      },
    },
  }

  require('zen-mode').setup(opts)
end
