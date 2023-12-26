return function()
  local container = true -- Set true if running Ollama in docker container, to avoid initializing Ollama twice.

  local opts = {
    model = 'mistral',
    display_mode = 'split',
    show_model = true,
    debug = false,
  }

  if container then
    opts.init = function()
      return
    end
  end

  require('gen').setup(opts)

  local icn = {
    Chat = '', --     
    Test = '', --    
    Regex = '', --   
    Comment = '', --  
    Code = '', --   
    Text = '', --   
    Items = '', --    
    Swap = '', -- 
    Keep = '', --  
    into = '', --  
  }

  require('gen').prompts = {
    [icn.Chat .. ' Ask about given context ' .. icn.Keep] = {
      prompt = 'Regarding the following text, $input:\n$text',
      model = 'mistral',
    },
    [icn.Chat .. ' Chat about anything ' .. icn.Keep] = {
      prompt = '$input',
      model = 'mistral',
    },
    [icn.Chat .. ' Ask about code context ' .. icn.Keep] = {
      prompt = 'Regarding the following code in $filetype language, $input:\n$text',
      model = 'deepseek-coder:6.7b',
    },
    [icn.Chat .. ' Chat about code ' .. icn.Keep] = {
      prompt = '$input',
      model = 'deepseek-coder:6.7b',
    },
    [icn.Regex .. ' Regex create ' .. icn.Swap] = {
      prompt = 'Create a regular expression for $filetype language that matches the following pattern and respond with ONLY the regex string itself and nothing else:\n$input',
      replace = true,
      no_auto_close = true,
      extract = '```$filetype\n(.-)```',
      model = 'deepseek-coder:6.7b',
    },
    [icn.Regex .. ' Regex explain ' .. icn.Keep] = {
      prompt = 'Explain the following regular expression:\n```$filetype\n$text\n```',
      extract = '```$filetype\n(.-)```',
      model = 'deepseek-coder:6.7b',
    },
    -- [icn.Comment .. ' Code ' .. icn.into .. ' JSDoc ' .. icn.Keep] = {
    --   prompt = 'Write JSDoc comments for the following $filetype code:\n```$filetype\n$text\n```',
    --   model = 'magicoder',
    -- },
    -- [icn.Comment .. ' JSDoc ' .. icn.into .. ' Code ' .. icn.Keep] = {
    --   prompt = 'Read the following comment and create the $filetype code below it:\n```$filetype\n$text\n```',
    --   extract = '```$filetype\n(.-)```',
    --   model = 'magicoder',
    -- },
    -- [icn.Test .. ' Unit Test add missing (React/Jest) ' .. icn.Keep] = {
    --   prompt = "Read the following $filetype code that includes some unit tests inside the 'describe' function. We are using Jest with React testing library, and the main component is reused by the tests via the customRender function. Detect if we have any missing unit tests and create them.\n```$filetype\n$text\n```",
    --   extract = '```$filetype\n(.-)```',
    --   model = 'magicoder',
    -- },
    [icn.Test .. ' Generate a unit test for function ' .. icn.Keep] = {
      prompt = 'Generate a unit test for the following $filetype function:\n```$filetype\n$text\n```',
      model = 'deepseek-coder:6.7b',
    },
    [icn.Code .. ' Code suggestions ' .. icn.Keep] = {
      prompt = 'Review the following $filetype code and make concise suggestions:\n```$filetype\n$text\n```',
      model = 'deepseek-coder:6.7b',
    },
    [icn.Code .. ' Explain code (Magi)' .. icn.Keep] = {
      prompt = 'Explain the following $filetype code in a very concise way:\n```$filetype\n$text\n```',
      model = 'magicoder',
    },
    [icn.Code .. ' Explain code ' .. icn.Keep] = {
      prompt = 'Explain the following $filetype code in a very concise way:\n```$filetype\n$text\n```',
      model = 'deepseek-coder:6.7b',
    },
    [icn.Code .. ' Fix code (Magi) ' .. icn.Swap] = {
      prompt = 'Fix the following $filetype code and respond only with your code:\n```$filetype\n$text\n```',
      replace = true,
      no_auto_close = false,
      extract = '```$filetype\n(.-)```',
      model = 'magicoder',
    },
    [icn.Code .. ' Fix code ' .. icn.Swap] = {
      prompt = 'Fix the following $filetype code and respond only with your code:\n```$filetype\n$text\n```',
      replace = true,
      no_auto_close = false,
      extract = '```$filetype\n(.-)```',
      model = 'deepseek-coder:6.7b',
    },
    [icn.Items .. ' Text ' .. icn.into .. ' List of items ' .. icn.Swap] = {
      prompt = 'Convert the following text, except for the code blocks, into a markdown list of items without additional quotes around it:\n$text',
      replace = true,
      no_auto_close = false,
      model = 'mistral',
    },
    [icn.Items .. ' List of items ' .. icn.into .. ' Text ' .. icn.Swap] = {
      prompt = 'Convert the following list of items into a block of text, without additional quotes around it. Modify the resulting text if needed to use better wording.\n$text',
      replace = true,
      no_auto_close = false,
      model = 'mistral',
    },
    [icn.Text .. ' Fix Grammar / Syntax in text ' .. icn.Swap] = {
      prompt = 'Fix the grammar and syntax in the following text, except for the code blocks, and without additional quotes around it:\n$text',
      replace = true,
      no_auto_close = false,
      model = 'mistral',
    },
    [icn.Text .. ' Reword text ' .. icn.Swap] = {
      prompt = 'Modify the following text, except for the code blocks, to use better wording, and without additional quotes around it:\n$text',
      replace = true,
      no_auto_close = false,
      model = 'mistral',
    },
    [icn.Text .. ' Simplify text ' .. icn.Swap] = {
      prompt = 'Modify the following text, except for the code blocks, to make it as simple and concise as possible and without additional quotes around it:\n$text',
      replace = true,
      no_auto_close = false,
      model = 'mistral',
    },
    [icn.Text .. ' Summarize text ' .. icn.Keep] = {
      prompt = 'Summarize the following text, except for the code blocks, without additional quotes around it:\n$text',
      model = 'mistral',
    },
  }
end
