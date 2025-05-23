return {
  "stevearc/conform.nvim",
  dependencies = "williamboman/mason.nvim",
  ft = { "go" },
  opts = {
    format_on_save = function(bufnr)
      if vim.b[bufnr].format_on_save == false then return end
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
    {
      "<leader>+", mode = { "n", "x" },
      function()
        if vim.b.format_on_save == nil then
          vim.b.format_on_save = vim.bo.filetype == "go"
        end
        vim.b.format_on_save = not vim.b.format_on_save
        vim.notify(
          string.format(
            "%s format-on-save",
            vim.b.format_on_save and "Enabled" or "Disabled"
        ))
      end, desc = "Toggle format-on-save",
    },
  },
}
