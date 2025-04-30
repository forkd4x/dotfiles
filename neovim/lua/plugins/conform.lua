return {
  "stevearc/conform.nvim",
  dependencies = "williamboman/mason.nvim",
  ft = { "go" },
  opts = {
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype ~= "go" then return end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      css = { "prettier" },
      go = { "gofmt" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "jq" },
      python = { "ruff_format" },
    },
  },
  keys = {
    {
      "<leader>=", mode = { "n", "x" },
      function() require("conform").format({ lsp_format = "fallback" }) end,
      desc = "Format",
    },
  },
}
