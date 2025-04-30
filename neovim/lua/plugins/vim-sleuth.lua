return {
  "tpope/vim-sleuth",
  config = function()
    for _, ft in pairs({ "css", "html", "javascript", "lua" }) do
      vim.g["sleuth_" .. ft .. "_defaults"] = "shiftwidth=2 tabstop=2"
    end
    for _, ft in pairs({ "go", "php" }) do
      vim.g["sleuth_" .. ft .. "_defaults"] = "noexpandtab"
    end
  end,
}
