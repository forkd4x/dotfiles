return {
  "ggandor/leap.nvim",
  config = function()
    vim.keymap.set("n", "s", "<Plug>(leap-anywhere)")
    vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap)")

    -- Grey out search space
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Ignore" })

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

    -- Search integration
    vim.api.nvim_create_autocmd("CmdlineLeave", {
      group = vim.api.nvim_create_augroup("LeapOnSearch", {}),
      callback = function ()
        local ev = vim.v.event
        local is_search_cmd = (ev.cmdtype == "/") or (ev.cmdtype == "?")
        local cnt = vim.fn.searchcount().total

        if is_search_cmd and (not ev.abort) and (cnt > 1) then
          -- Allow CmdLineLeave-related chores to be completed before
          -- invoking Leap.
          vim.schedule(function()
            -- We want "safe" labels, but no auto-jump (as the search
            -- command already does that), so just use `safe_labels`
            -- as `labels`, with n/N removed.
            local safe_labels = require("leap").opts.safe_labels
            if type(safe_labels) == "string" then
              safe_labels = vim.fn.split(safe_labels, "\\zs")
            end
            local labels = vim.tbl_filter(function (l) return l:match("[^nN]") end,
              safe_labels)
            -- For `pattern` search, we never need to adjust conceallevel
            -- (no user input).
            local vim_opts = require("leap").opts.vim_opts
            vim_opts["wo.conceallevel"] = nil

            require("leap").leap({
              pattern = vim.fn.getreg("/"),  -- last search pattern
              target_windows = { vim.fn.win_getid() },
              opts = {
                safe_labels = "",
                labels = labels,
                vim_opts = vim_opts,
              },
            })
          end)
        end
      end,
    })

  end,
}
