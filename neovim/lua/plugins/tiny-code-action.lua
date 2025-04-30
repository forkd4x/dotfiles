return {
  "rachartier/tiny-code-action.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  event = "LspAttach",
  opts  = {
    picker = { "snacks" },
  },
  keys = {
    { "gra", function()
        require("tiny-code-action").code_action({})
      end, desc = "Code Actions"
    },
  },
}
