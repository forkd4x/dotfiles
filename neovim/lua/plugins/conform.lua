return {
  "stevearc/conform.nvim",
  dependencies = "williamboman/mason.nvim",
  ft = { "go" },
  opts = {
    format_on_save = function(bufnr)
      if vim.b[bufnr].format_on_save == nil then
        vim.b[bufnr].format_on_save = (vim.bo[bufnr].filetype == "go")
      end
      if vim.b[bufnr].format_on_save == false then return end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      css = { "prettier" },
      go = { "gofmt" },
      html = { "prettier" },
      htmldjango = { "djlint" },
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
        vim.b.format_on_save = not vim.b.format_on_save
        vim.notify(
          string.format(
            "%s format-on-save",
            vim.b.format_on_save and "Enabled" or "Disabled"
        ))
        -- Ensure next :write formats buffer even if unmodified
        if vim.b.format_on_save then
          vim.bo.modified = true
        end
      end, desc = "Toggle format-on-save",
    },
  },
}
