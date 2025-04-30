return {
  {
    "fladson/vim-kitty",
    ft = "kitty",
  },

  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    config = function()
      require("smart-splits").setup({
        at_edge = "stop",
      })
      local modes = { "n", "i", "x", "c" }
      vim.keymap.set(modes, "<C-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set(modes, "<C-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set(modes, "<C-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set(modes, "<C-l>", require("smart-splits").move_cursor_right)
      vim.keymap.set(modes, "<C-A-h>", require("smart-splits").resize_left)
      vim.keymap.set(modes, "<C-A-j>", require("smart-splits").resize_down)
      vim.keymap.set(modes, "<C-A-k>", require("smart-splits").resize_up)
      vim.keymap.set(modes, "<C-A-l>", require("smart-splits").resize_right)
    end,
  },

  {
    "mikesmithgh/kitty-scrollback.nvim",
    config = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
  },
}
