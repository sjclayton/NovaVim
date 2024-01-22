return function()
  local opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '_' },
      topdelete = { text = '-' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    preview_config = {
      border = 'rounded',
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns
      local map = require('core.helpers').map

      -- stylua: ignore start
      map("n", "]h", gs.next_hunk, { buffer = buffer, desc = "Next hunk"})
      map("n", "[h", gs.prev_hunk, { buffer = buffer, desc = "Prev hunk"})
      map({ "n", "v" }, "<leader>gsh", ":Gitsigns stage_hunk<CR>", { buffer = buffer, desc = "Stage hunk"} )
      map({ "n", "v" }, "<leader>grh", ":Gitsigns reset_hunk<CR>",{ buffer = buffer, desc = "Reset hunk"})
      map("n", "<leader>gsb", gs.stage_buffer, { buffer = buffer, desc ="Stage buffer"})
      map("n", "<leader>gu", gs.undo_stage_hunk, { buffer = buffer, desc ="Undo stage hunk"})
      map("n", "<leader>grb", gs.reset_buffer, { buffer = buffer, desc ="Reset buffer"})
      map("n", "<leader>gp", gs.preview_hunk_inline, { buffer = buffer, desc ="Preview hunk"})
      map("n", "<leader>gB", function() gs.blame_line({ full = true }) end, { buffer = buffer, desc ="Line blame (full)"})
      map("n", "<leader>gb", gs.toggle_current_line_blame, { buffer = buffer, desc ="Toggle line blame (current line)"})
      map("n", "<leader>gd", gs.diffthis, { buffer = buffer, desc = "Diff this"})
      map("n", "<leader>gD", function() gs.diffthis("~") end, { buffer = buffer, desc = "Diff this ~"})
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = buffer, desc = "GitSigns select hunk"})
    end,
  }

  require('gitsigns').setup(opts)
end
