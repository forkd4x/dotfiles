return {
  "ggandor/leap.nvim",
  config = function()
    vim.keymap.set("n", "s", "<Plug>(leap-anywhere)")
    vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap)")

    -- Create remote versions of all a/i text objects
    local remote_text_object = function(prefix)
      local ok, ch = pcall(vim.fn.getcharstr)   -- pcall for handling <C-c>
      if not ok or (ch == vim.keycode("<esc>")) then
        return
      end
      require("leap.remote").action { input = prefix .. ch }
    end
    vim.keymap.set({ "x", "o" }, "ra", function() remote_text_object("a") end)
    vim.keymap.set({ "x", "o" }, "ri", function() remote_text_object("i") end)
    vim.keymap.set({ "x", "o" }, "rr", function()
      -- Force linewise selection.
      local V = vim.fn.mode(true):match("V") and "" or "V"
      -- In any case, move horizontally, to trigger operations.
      local input = vim.v.count > 1 and (vim.v.count - 1 .. "j") or "hl"
      -- With `count=false` you can skip feeding count to the command
      -- automatically (we need -1 here, see above).
      require("leap.remote").action { input = V .. input, count = false }
    end)
  end,
}
