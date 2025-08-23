return {
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set("n", "s", "<Plug>(leap-anywhere)")
      vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap)")

      -- Grey out search space
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Ignore" })

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
  },

  {
    "rasulomaroff/telepath.nvim",
    dependencies = "ggandor/leap.nvim",
    config = function()
      require("telepath").use_default_mappings()
    end,
  }
}
