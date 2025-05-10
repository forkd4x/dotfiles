return {
  "neovim/nvim-lspconfig",
  dependencies = "mason-org/mason-lspconfig.nvim",
  enabled = vim.uv.os_uname().sysname == "Darwin",
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "basedpyright",
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

    vim.lsp.config("*", {})

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          hint = { enable = true },
        }
      }
    })

    vim.diagnostic.config({
      severity_sort = true,
      signs = false,
      virtual_text = true,
    })

    vim.keymap.set({ "n", "i" }, "<C-s>", function() vim.lsp.buf.signature_help() end)
    vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "Diagnostic Info" })
    vim.keymap.set("n", "grI", [[<cmd>silent check vim.lsp<cr>]], { desc = "Info" })
    vim.keymap.set("n", "grR", [[<cmd>LspRestart<cr>]], { desc = "Restart" })

    vim.keymap.set("n", "grh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Toggle Inlay Hints" })

    vim.keymap.set("n", "grv", function()
      vim.diagnostic.config({
        virtual_text = not vim.diagnostic.config().virtual_text,
      })
    end, { desc = "Toggle Virtual Text" })
  end
}
