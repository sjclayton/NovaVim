local map = require('core.helpers').map

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
    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '_' },
      topdelete = { text = '-' },
      changedelete = { text = '~' },
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
      local opts = { buffer = buffer }

      -- stylua: ignore start
      map("n", "]h", gs.next_hunk, "Next hunk", opts)
      map("n", "[h", gs.prev_hunk, "Prev hunk", opts)
      map({ "n", "v" }, "<leader>gsh", ":Gitsigns stage_hunk<CR>", "Stage hunk", opts )
      map({ "n", "v" }, "<leader>grh", ":Gitsigns reset_hunk<CR>","Reset hunk", opts)
      map("n", "<leader>gsb", gs.stage_buffer, "Stage buffer", opts)
      map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk", opts)
      map("n", "<leader>grb", gs.reset_buffer, "Reset buffer", opts)
      map("n", "<leader>gp", gs.preview_hunk_inline, "Preview hunk", opts)
      map("n", "<leader>gB", function() gs.blame_line({ full = true }) end, "Line blame (full)", opts)
      map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle line blame (current line)", opts)
      map("n", "<leader>gd", gs.diffthis, "Diff this", opts)
      map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff this ~", opts)
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns select hunk", opts)
    end,
  }

  require('gitsigns').setup(opts)
end
