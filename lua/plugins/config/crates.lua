return function()
  local opts = {
    src = {
      cmp = {
        enabled = true,
      },
    },
    popup = {
      autofocus = true,
    },
  }

  require('crates').setup(opts)

  -- ensure rust crates cmp source is available
  require('crates.src.cmp').setup()
end
