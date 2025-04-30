return {
  "neovim/nvim-lspconfig",
  dependencies = "williamboman/mason-lspconfig.nvim",
  enabled = vim.uv.os_uname().sysname == "Darwin",
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "emmet_language_server",
        "golangci_lint_ls", -- +"golangci-lint"
        "gopls",
        "intelephense",
        "jsonls",
        "lua_ls",
        "pyright",
        "ruff",
        "templ",
        "yamlls",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
        ["emmet_language_server"] = function()
          require("lspconfig").emmet_language_server.setup({
            filetypes = { "css", "html", "javascript", "phtml", "templ" }
          })
        end,
        ["pyright"] = function()
          require("lspconfig").pyright.setup({
            settings = { python = { pythonPath = ".venv/bin/python" } },
          })
        end,
        ["ruff"] = function()
          require("lspconfig").ruff.setup({
            ---@diagnostic disable-next-line: unused-local
            on_attach = function(client, bufnr)
              -- Prevent "No information available" from ruff on vim.lsp.buf.hover()
              client.server_capabilities.hoverProvider = false
            end,
          })
        end,
      },
    })
    vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "Diagnostic Info" })
    vim.keymap.set("n", "grI", [[<cmd>silent check vim.lsp<cr>]], { desc = "Info" })
    vim.keymap.set("n", "grR", [[<cmd>LspRestart<cr>]], { desc = "Restart" })
    vim.keymap.set("n", "grv", function()
      vim.diagnostic.config({
        virtual_text = not vim.diagnostic.config().virtual_text,
      })
    end, { desc = "Toggle Virtual Text" })
    vim.diagnostic.config({ severity_sort = true, signs = false })
    vim.keymap.set({ "n", "i" }, "<C-s>", function() vim.lsp.buf.signature_help() end)
  end
}
