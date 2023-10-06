return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = {
      -- _extmark_signs = false,
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
      map("n", "]h", gs.next_hunk, { buffer = buffer, desc = "Next Hunk"})
      map("n", "[h", gs.prev_hunk, { buffer = buffer, desc = "Prev Hunk"})
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { buffer = buffer, desc = "Stage Hunk"} )
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>",{ buffer = buffer, desc = "Reset Hunk"})
      map("n", "<leader>ghS", gs.stage_buffer, { buffer = buffer, desc ="Stage Buffer"})
      map("n", "<leader>ghu", gs.undo_stage_hunk, { buffer = buffer, desc ="Undo Stage Hunk"})
      map("n", "<leader>ghR", gs.reset_buffer, { buffer = buffer, desc ="Reset Buffer"})
      map("n", "<leader>ghp", gs.preview_hunk, { buffer = buffer, desc ="Preview Hunk"})
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { buffer = buffer, desc ="Blame Line"})
      map("n", "<leader>ghd", gs.diffthis, { buffer = buffer, desc = "Diff This"})
      map("n", "<leader>ghD", function() gs.diffthis("~") end, { buffer = buffer, desc = "Diff This ~"})
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = buffer, desc = "GitSigns Select Hunk"})
      end,
    },
  },
}
