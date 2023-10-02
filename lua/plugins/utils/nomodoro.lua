return {
  {
    'dbinagi/nomodoro',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      local map = require('core.helpers').map

      map('n', '<leader>nm', '<cmd>NomoMenu<cr>', { desc = 'NomoMenu' })
      map('n', '<leader>nw', '<cmd>NomoWork<cr>', { desc = 'NomoWork' })
      map('n', '<leader>nb', '<cmd>NomoBreak<cr>', { desc = 'NomoBreak' })
      map('n', '<leader>ns', '<cmd>NomoStop<cr>', { desc = 'NomoStop' })

      require('nomodoro').setup({
        work_time = 25,
        break_time = 5,
        menu_available = true,
        texts = {
          on_break_complete = 'BACK TO WORK!',
          on_work_complete = 'BREAK TIME!',
          status_icon = '󰀠 ',
          timer_format = '!%0M:%0S', -- To include hours: '!%0H:%0M:%0S'
        },
        on_work_complete = function() end,
        on_break_complete = function() end,
      })
    end,
  },
}
