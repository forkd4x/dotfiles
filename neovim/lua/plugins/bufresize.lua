return {
  "kwkarlwang/bufresize.nvim",
  config = function()
    require("bufresize").setup()

    -- Fix cmdheight changing when using trouble.nvim
    vim.g.cmdheight = vim.o.cmdheight
    vim.api.nvim_create_autocmd("VimResized", {
      callback = function()
        vim.o.cmdheight = vim.g.cmdheight
      end
    })

    -- Fix statusline disappearing on mouse click
    vim.keymap.del({ "n", "i", "x" }, "<LeftRelease>")
  end,
}
