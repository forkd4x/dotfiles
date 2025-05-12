return {
  "Wansmer/treesj",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
    use_default_keymaps = false,
  },
  keys = {
    { "<leader>j", [[:TSJSplit<cr>]], desc = "TreeSJ Split" },
    { "<leader>J", [[:TSJJoin<cr>]], desc = "TreeSJ Join" },
  }
}
