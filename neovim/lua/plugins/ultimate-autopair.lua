return {
  "altermo/ultimate-autopair.nvim",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    close = { enable = true },
    fastwarp = {
      enable = true,
      nocursormove = false,
    },
    space2 = { enable = true },
    tabout = {
      enable = true,
      hopout = true,
    },
    -- Fix <cr> between tags indenting properly
    { ">", "<", newline = true },
  },
}
