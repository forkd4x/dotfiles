return {
  "abecodes/tabout.nvim",
  event = "InsertCharPre",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("tabout").setup({})
    vim.keymap.set("i", "<tab>", [[<Plug>(TaboutMulti)]])
    vim.keymap.set("i", "<S-tab>", [[<Plug>(TaboutBackMulti)]])
  end,
}
