return {
  "lambdalisue/vim-suda",
  init = function()
    vim.g.suda_smart_edit = 1
    vim.keymap.set(
      { "n", "x" },
      "<leader>w",
      [[<cmd>silent! wa<cr><cmd>redraw<cr>]],
      { desc = "Save files" }
    )
  end
}
