return function()
  function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    vim.keymap.set('t', '<C-q>', [[<C-\><C-n><C-W>q]], opts)
  end

  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  local opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 18
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
  }

  require('toggleterm').setup(opts)
end
