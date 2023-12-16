return function()
  local opts = {
    zindex = 20,
    window = {
      backdrop = 0.90,
      width = 0.75,
    },
    plugins = {
      options = {
        laststatus = 0,
      },
      gitsigns = { enabled = true },
      tmux = { enabled = true },
    },
  }

  require('zen-mode').setup(opts)
end
