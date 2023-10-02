return {
  {
    'huggingface/llm.nvim',
    keys = {
      { '<leader>ch', '<CMD>:LLMToggleAutoSuggest<CR>', { desc = 'Toggle Starcoder AI' } },
    },
    config = function()
      require('llm').setup({
        api_token = nil, -- cf Install paragraph
        model = 'bigcode/starcoder', -- can be a model ID or an http(s) endpoint
        tokens_to_clear = { '<|endoftext|>' }, -- tokens to remove from the model's output
        -- parameters that are added to the request body
        query_params = {
          max_new_tokens = 60,
          temperature = 0.2,
          top_p = 0.95,
          stop_tokens = nil,
        },
        -- set this if the model supports fill in the middle
        fim = {
          enabled = true,
          prefix = '<fim_prefix>',
          middle = '<fim_middle>',
          suffix = '<fim_suffix>',
        },
        debounce_ms = 150,
        accept_keymap = '<Tab>',
        dismiss_keymap = '<S-Tab>',
        tls_skip_verify_insecure = false,
        -- llm-ls configuration, cf llm-ls section
        lsp = {
          bin_path = nil,
          version = '0.2.0',
        },
        tokenizer = { -- cf Tokenizer paragraph
          repository = 'bigcode/starcoder',
        },
        context_window = 8192, -- max number of tokens for the context window
      })
    end,
  },
}
