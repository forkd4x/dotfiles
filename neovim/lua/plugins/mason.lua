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
    opts = {},
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = vim.uv.os_uname().sysname == "Darwin",
    opts = {
      ensure_installed = {
        "basedpyright",
        "djlint",
        "dockerls",
        "emmet_language_server",
        "golangci-lint",
        "golangci_lint_ls",
        "gopls",
        "html",
        "intelephense",
        "jsonls",
        "lemminx",
        "lua_ls",
        "prettier",
        "ruff",
        "templ",
        "ts_ls",
        "yamlls",
      }
    },
  },
}
