return {
  "neovim/nvim-lspconfig",
  dependencies = "williamboman/mason-lspconfig.nvim",
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
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
        ["emmet_language_server"] = function()
          require("lspconfig").emmet_language_server.setup({
            filetypes = { "css", "html", "javascript", "phtml", "templ" }
          })
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            settings = {
              Lua = {
                hint = { enable = true },
              },
            },
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
    vim.keymap.set("n", "grh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Toggle Inlay Hints" })

    vim.diagnostic.config({
      severity_sort = true,
      signs = false,
      virtual_text = true,
    })
    vim.keymap.set("n", "grv", function()
      vim.diagnostic.config({
        virtual_text = not vim.diagnostic.config().virtual_text,
      })
    end, { desc = "Toggle Virtual Text" })

    vim.keymap.set({ "n", "i" }, "<C-s>", function() vim.lsp.buf.signature_help() end)
  end
}
