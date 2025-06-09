return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup({})
    vim.keymap.set("n", "[t", require("todo-comments").jump_prev)
    vim.keymap.set("n", "]t", require("todo-comments").jump_next)
  end,
  keys = {
    { "<leader>tt", [[<cmd>TodoTrouble toggle<cr>]], desc = "Todo Trouble" },
    ---@diagnostic disable-next-line: undefined-field
    { "<leader>ts", function() Snacks.picker.todo_comments() end, desc = "Todo Snacksj" },
  },
}
