return {
  {
    "mason-org/mason.nvim",
    enabled = vim.uv.os_uname().sysname == "Darwin",
    opts = {},
    keys = {
      { "<leader>M", [[<cmd>Mason<cr>]], desc = "Mason" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = vim.uv.os_uname().sysname == "Darwin",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "basedpyright",
          "dockerls",
          "emmet_language_server",
          "golangci_lint_ls", -- +"golangci-lint"
          "gopls",
          "intelephense",
          "jsonls",
          "lua_ls",
          "ruff",
          "yamlls",
        },
      })
    end,
  },

}
