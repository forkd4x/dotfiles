return {
  "Wansmer/treesj",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    local utils = require("treesj.langs.utils")
    local html = require("treesj.langs.html")
    require("treesj").setup({
      use_default_keymaps = false,
      langs = {
        htmldjango = utils.merge_preset(html, {}),
      },
    })
  end,
  keys = {
    { "<leader>j", [[:TSJSplit<cr>]], desc = "TreeSJ Split" },
    { "<leader>J", [[:TSJJoin<cr>]], desc = "TreeSJ Join" },
  }
}
