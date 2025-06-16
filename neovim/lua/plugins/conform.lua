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
      return { lsp_format = "fallback", timeout_ms = 2000 }
    end,
    formatters_by_ft = {
      css = { "prettier" },
      go = { "gofmt" },
      html = { "prettier" },
      htmldjango = { "djlint", "prettier" },
      javascript = { "prettier" },
      json = { "jq" },
      python = { "ruff_format" },
    },
  },
  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({
          lsp_format = "fallback",
          timeout_ms = 2000,
        })
      end,
      desc = "Format",
    },
    {
      "<leader>=", mode = { "x" },
      function()
        local conform = require("conform")
        require("conform").format_lines(
          conform.list_formatters_for_buffer(0),
          vim.api.nvim_buf_get_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false),
          { lsp_format = "fallback", timeout_ms = 2000 },
          function(err, lines)
              if err or lines == nil then
                vim.notify(vim.inspect(err))
              else
                vim.api.nvim_buf_set_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false, lines)
              end
          end
        )
      end,
      desc = "Format range",
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
