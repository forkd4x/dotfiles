vim.keymap.set(
  { "n", "x" },
  "<leader>w",
  [[<cmd>silent! wa<cr><cmd>redraw<cr>]],
  { desc = "Save files" }
)

return {
  "lambdalisue/vim-suda",
  keys = {
    { "<leader>W", [[<cmd>SudaWrite<cr>]], desc = "Save file with sudo" },
  },
}
