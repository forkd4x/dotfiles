return {
  "kwkarlwang/bufresize.nvim",
  config = function()
    require("bufresize").setup()
    -- Fix statusline disappearing on mouse click
    vim.keymap.del({ "n", "i" }, "<LeftRelease>")
  end,
}
