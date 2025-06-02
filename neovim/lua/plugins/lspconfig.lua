return {
  "neovim/nvim-lspconfig",
  dependencies = "mason-org/mason-lspconfig.nvim",
  enabled = vim.uv.os_uname().sysname == "Darwin",
  config = function()
    vim.lsp.config("*", {
      on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
      end,
    })

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

    vim.keymap.set("n", "grI", [[<cmd>silent checkhealth vim.lsp<cr>]], { desc = "Info" })

    vim.keymap.set("n", "grR", function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients > 0 then
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          vim.cmd("LspRestart " .. client.name)
          vim.notify("Restarted " .. client.name, vim.log.levels.INFO)
        end
      else
        vim.notify("No active LSP clients", vim.log.levels.WARN)
      end
    end, { desc = "Restart" })

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
