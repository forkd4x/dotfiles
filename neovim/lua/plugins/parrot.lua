return {
  "frankroeder/parrot.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("parrot").setup({
      chat_free_cursor = true,
      chat_user_prefix = "💬:",
      llm_prefix = "🤖:",
      online_model_selection = true,
      providers = {
        gemini = { api_key = { "cat", vim.fn.expand("~/.dotfiles/gemini.key") } },
        openai = { api_key = { "cat", vim.fn.expand("~/.dotfiles/openai.key") } },
      },
      show_context_hints = true,
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*/parrot/chats/*.md",
      callback = function()
        vim.schedule(function()
          vim.keymap.set("n", "<cr>", [[<cmd>PrtChatResponde<cr>]], { buffer = true })
          vim.keymap.set("n", "<esc>", [[<cmd>PrtChatStop<cr>]], { buffer = true })
          vim.keymap.set({ "n", "x", "o" }, "[[", [[?^\(💬:\|🤖:\)<cr>]], { buffer = true, desc = "Previous Prompt" })
          vim.keymap.set({ "n", "x", "o" }, "]]", [[/^\(💬:\|🤖:\)<cr>]], { buffer = true, desc = "Next Prompt" })
        end)
      end,
    })
  end,
  cmd = { "PrtChatNew" },
  keys = {
    { "<leader>an", mode = { "n" }, [[:PrtChatNew<cr>]], desc = "New Chat" },
    { "<leader>aN", mode = { "n" }, [[:PrtChatNew<cr>:only<cr>]], desc = "New Chat Only" },
    { "<leader>an", mode = { "x" }, [[:<C-u>'<,'>PrtChatNew<cr>]], desc = "New Chat" },
    { "<leader>av", mode = { "n" }, [[:PrtChatToggle<cr>]], desc = "Toggle Chat" },
    { "<leader>av", mode = { "x" }, [[:<C-u>'<,'>PrtChatToggle<cr>]], desc ="Toggle Chat" },
    { "<leader>ap", mode = { "x" }, [[:<C-u>'<,'>PrtChatPaste<cr>]], desc = "Chat Paste" },
    { "<leader>aP", mode = { "n", "x" }, [[:PrtProvider<cr>]], desc = "Select Provider" },
    { "<leader>aM", mode = { "n", "x" }, [[:PrtModel<cr>]], desc = "Select Model" },
    { "<leader>at", mode = { "n" }, [[:PrtThinking<cr>]], desc = "Toggle thinking" },
    { "<leader>as", mode = { "n", "x" }, [[:PrtStatus<cr>]], desc = "Show Status" },
    { "<leader>ar", mode = { "x" }, [[:<C-u>'<,'>PrtRewrite<cr>]], desc = "Rewrite" },
    { "<leader>ae", mode = { "n", "x" }, [[:<C-u>'<,'>PrtEdit<cr>]], desc = "Edit" },
    { "<leader>aa", mode = { "n" }, [[:PrtAppend<cr>]], desc = "Append" },
    { "<leader>aa", mode = { "x" }, [[:<C-u>'<,'>PrtAppend<cr>]], desc = "Append" },
    { "<leader>ab", mode = { "n" }, [[:PrtPrepend<cr>]], desc = "Prepend" },
    { "<leader>ab", mode = {  "x" }, [[:<C-u>'<,'>PrtPrepend<cr>]], desc = "Prepend" },
    { "<leader>aR", mode = { "n", "x" }, [[:<C-u>'<,'>PrtRetry<cr>]], desc = "Retry" },
    { "<leader>ai", mode = { "x" }, [[:<C-u>'<,'>PrtImplement<cr>]], desc = "Implement" },
  },
}
