return {
  "frankroeder/parrot.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("parrot").setup({
      chat_free_cursor = true,
      chat_user_prefix = "💬:",
      llm_prefix = "🤖:",
      providers = {
        openai = {
          name = "openai",
          api_key = { "cat", vim.fn.expand("~/.dotfiles/openai.key") },
          endpoint = "https://api.openai.com/v1/chat/completions",
          params = {
            chat = { temperature = 1.1, top_p = 1 },
            command = { temperature = 1.1, top_p = 1 },
          },
          topic = {
            model = "gpt-4.1-nano",
            params = { max_completion_tokens = 64 },
          },
          models ={
            "gpt-4.1",
            "o4-mini",
          }
        },
        gemini = {
          name = "gemini",
          endpoint = function(self)
            return "https://generativelanguage.googleapis.com/v1beta/models/"
              .. self._model
              .. ":streamGenerateContent?alt=sse"
          end,
          api_key = { "cat", vim.fn.expand("~/.dotfiles/gemini.key") },
          params = {
            chat = { temperature = 1.1, topP = 1, topK = 10, maxOutputTokens = 8192 },
            command = { temperature = 0.8, topP = 1, topK = 10, maxOutputTokens = 8192 },
          },
          topic = {
            model = "gemini-2.5-flash",
            params = { maxOutputTokens = 64 },
          },
          headers = function(self)
            return {
              ["Content-Type"] = "application/json",
              ["x-goog-api-key"] = self.api_key,
            }
          end,
          models = {
            "gemini-2.5-pro",
            "gemini-2.5-flash",
            "gemini-2.0-flash-lite",
          },
          preprocess_payload = function(payload)
            local contents = {}
            local system_instruction = nil
            for _, message in ipairs(payload.messages) do
              if message.role == "system" then
                system_instruction = { parts = { { text = message.content } } }
              else
                local role = message.role == "assistant" and "model" or "user"
                table.insert(
                  contents,
                  { role = role, parts = { { text = message.content:gsub("^%s*(.-)%s*$", "%1") } } }
                )
              end
            end
            local gemini_payload = {
              contents = contents,
              generationConfig = {
                temperature = payload.temperature,
                topP = payload.topP or payload.top_p,
                maxOutputTokens = payload.max_tokens or payload.maxOutputTokens,
              },
            }
            if system_instruction then
              gemini_payload.systemInstruction = system_instruction
            end
            return gemini_payload
          end,
          process_stdout = function(response)
            if not response or response == "" then
              return nil
            end
            local success, decoded = pcall(vim.json.decode, response)
            if
              success
              and decoded.candidates
              and decoded.candidates[1]
              and decoded.candidates[1].content
              and decoded.candidates[1].content.parts
              and decoded.candidates[1].content.parts[1]
            then
              return decoded.candidates[1].content.parts[1].text
            end
            return nil
          end,
        },
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
