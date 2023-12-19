return function()
  local opts = {
    work_time = 25,
    break_time = 5,
    texts = {
      on_break_complete = 'BACK TO WORK!',
      on_work_complete = 'BREAK TIME!',
      status_icon = '󰀠 ',
      -- timer_format = '!%0M:%0S', -- To include hours: '!%0H:%0M:%0S'
      timer_format = '!%0Mm',
    },
    on_work_complete = function() end,
    on_break_complete = function() end,
  }
  require('nomodoro').setup(opts)
end
