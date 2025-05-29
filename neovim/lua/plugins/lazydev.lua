return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "~/.config/hammerspoon/Spoons/EmmyLua.spoon/annotations" },
    },
  },
}
