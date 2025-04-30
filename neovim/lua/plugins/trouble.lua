return {
  "folke/trouble.nvim",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("trouble").setup({
      auto_jump = true,
      focus = true,
      keys = { ["<tab>"] = "fold_toggle" },
    })
    vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "Normal" })
  end,
  specs = {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          win = {
            input = {
              keys = {
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      })
    end,
  },
  cmd = "Trouble",
  keys = {
    { "gd", [[<cmd>Trouble lsp_definitions<cr>]], desc = "Definitions" },
    { "grr", [[<cmd>Trouble lsp_references<cr>]], desc = "References" },
    { "<leader>dd", [[<cmd>Trouble diagnostics toggle<cr>]], desc = "Trouble Diagnostics" },
    { "<leader>q", [[<cmd>Trouble quickfix toggle<cr>]], desc = "Trouble Quickfix" },
    { "<leader>o", [[<cmd>Trouble symbols toggle focus=true<cr>]], desc = "Symbols" },
  },
}
