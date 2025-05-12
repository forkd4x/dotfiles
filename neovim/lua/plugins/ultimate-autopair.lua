return {
  "altermo/ultimate-autopair.nvim",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    close = {
      map = "<A-c>",
      cmap = "<A-c>",
    },
    fastwarp = {
      map = "<A-f>",
      cmap = "<A-f",
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
