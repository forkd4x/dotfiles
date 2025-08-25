return {
  "altermo/ultimate-autopair.nvim",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    close = {
      map = "<A-e>",
      cmap = "<A-e>",
    },
    fastwarp = {
      map = "<C-e>",
      rmap = "<C-q>",
      cmap = "<C-e>",
      rcmap = "<C-q>",
      nocursormove = false,
    },
    space2 = { enable = true },
    extensions = {
      filetype = {
        nft = { "snacks_picker_input" },
      },
    },

    -- Fix <cr> between tags indenting properly
    {
      ">", "<",
      disable_start = true,
      newline = true,
      ft = { "html", "htmldjango", "xml" },
    },
  },
}
