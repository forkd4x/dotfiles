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

    -- Fix <cr> between tags indenting properly
    { ">", "<", newline = true, ft = { "html" } },
  },
}
