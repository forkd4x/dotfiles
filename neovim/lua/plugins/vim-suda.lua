vim.keymap.set("n", "<leader>w", [[<cmd>silent! wa<cr>]], { desc = "Save files" })

return {
  "lambdalisue/vim-suda",
  keys = {
    { "<leader>W", [[<cmd>SudaWrite<cr>]], desc = "Save file with sudo" },
  },
}
