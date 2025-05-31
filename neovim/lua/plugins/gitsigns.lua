return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPost",
  config = function()
    local gs = require("gitsigns")
    gs.setup({})
    vim.keymap.set({ "o", "x" }, "ig", [[:<C-u>Gitsigns select_hunk<cr>]])
    vim.keymap.set("n", "<leader>gd", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
    vim.keymap.set("n", "<leader>gl", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
    vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
    vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })

    local function get_range() return { vim.fn.line("."), vim.fn.line("v") } end
    vim.keymap.set("x", "<leader>gr", function() gs.reset_hunk(get_range()) end, { desc = "Reset Hunk" })
    vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage/Unstage Hunk" })
    vim.keymap.set("x", "<leader>gs", function() gs.stage_hunk(get_range()) end, { desc = "Stage/Unstage Hunk" })

    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(
      function() gs.nav_hunk("next") end, function() gs.nav_hunk("prev") end
    )
    vim.keymap.set({ "n", "x", "o" }, "]g", next_hunk_repeat, { desc = "Next Git Hunk" })
    vim.keymap.set({ "n", "x", "o" }, "[g", prev_hunk_repeat, { desc = "Previous Git Hunk" })
  end,
}
