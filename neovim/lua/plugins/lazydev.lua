return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      "mini.nvim",
      "snacks.nvim",
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "~/.config/hammerspoon/Spoons/EmmyLua.spoon/annotations" },
    },
  },
}
