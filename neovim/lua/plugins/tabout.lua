return {
  "abecodes/tabout.nvim",
  event = "InsertCharPre",
  config = function()
    require("tabout").setup({
      ignore_beginning = false,
    })
    vim.keymap.set("i", "<tab>", [[<Plug>(TaboutMulti)]])
    vim.keymap.set("i", "<S-tab>", [[<Plug>(TaboutBackMulti)]])
  end,
}
