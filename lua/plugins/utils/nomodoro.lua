return {
  {
    'dbinagi/nomodoro',
    keys = {
      { '<leader>nw', '<cmd>NomoWork<cr>', desc = 'Nomo - Start Work', noremap = true },
      { '<leader>nb', '<cmd>NomoBreak<cr>', desc = 'Nomo - Start Break', noremap = true },
      { '<leader>ns', '<cmd>NomoStop<cr>', desc = 'Nomo - Stop Timer', noremap = true },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('nomodoro').setup({
        work_time = 25,
        break_time = 5,
        menu_available = true,
        texts = {
          on_break_complete = 'BACK TO WORK!',
          on_work_complete = 'BREAK TIME!',
          status_icon = '󰀠 ',
          -- timer_format = '!%0M:%0S', -- To include hours: '!%0H:%0M:%0S'
          timer_format = '!%0Mm', -- To include hours: '!%0H:%0M:%0S'
        },
        on_work_complete = function() end,
        on_break_complete = function() end,
      })
    end,
  },
}
