local function grep_multiline(cwd)
  Snacks.picker.grep({ cwd = cwd, search = " -- -U --multiline-dotall" })
  vim.defer_fn(function()
    vim.cmd("normal I")
  end, 100)
end

return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    explorer = { replace_netrw = false },
    image = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      prompt = "❯ ",
      layouts = {
        custom = {
          sidebar = {
            preview = "main",
            layout = {
              backdrop = false,
              width = 40,
              min_width = 40,
              height = 0,
              position = "left",
              border = "none",
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = "double",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "none", wo = { winhighlight = "NormalFloat:Normal" } },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
          layout = {
            box = "vertical",
            border = "rounded",
            backdrop = false,
            height = 0.8,
            width = 0.8,
            min_width = 80,
            title = "{title} {live} {flags}",
            { win = "input", height = 1, border = "bottom" },
            { win = "list" },
            { win = "preview", title = "{preview}", height = 0.5, border = "top" },
          },
        },
      },
      layout = {
        preset = "custom",
      },
      sources = {
        explorer = {
          auto_close = true,
          win = {
            list = {
              wo = "NormalFloat:Float",
            },
          },
        },
        projects = {
          win = {
            input = {
              keys = {
                ["<C-x>"] = { "delete_projects", mode = { "n", "i" } },
              },
            },
          },
        },
        spelling = {
          layout = {
            preset = "custom",
            preview = false,
          },
        },
      },
      matcher = {
        frecency = true,
      },
      actions = {
        delete_projects = function(picker, _)
          Snacks.picker.actions.close(picker)
          local items = picker:selected({ fallback = true })
          local what = #items == 1 and items[1].file or #items .. " projects"
          vim.notify("Deleting " .. what .. " from ShaDa...", vim.log.levels.INFO)
          vim.cmd("redraw")
          vim.defer_fn(function()
            vim.cmd("edit " .. vim.fn.stdpath("state") .. "/shada/main.shada")
            local deleted = 0
            for _, item in ipairs(items) do
              local regex =
                "^\\S\\(\\n\\s\\|[^\\n]\\)\\{-}"
                .. vim.fn.escape(item.file, "/\\")
                .. "\\_.\\{-}\\n*\\ze\\(^\\S\\|\\%$\\)"
              -- Count how many entries will be deleted
              deleted = deleted + vim.fn.searchcount({
                maxcount = 10000,
                pattern = vim.fn.escape(item.file, "/\\"),
              }).total
              -- Remove entries by substituting with empty string
              vim.cmd("%s/" .. regex .. "//g")
            end
            vim.cmd("write!")
            vim.cmd("rshada!")
            vim.cmd("bwipeout!")
            vim.notify("Removed " .. deleted .. " entries for " .. what, vim.log.levels.INFO)
            Snacks.picker.projects()
          end, 100)
        end,
        open_oil = function(picker, item)
          if not item then return end
          Snacks.picker.actions.cd(picker, item)
          Snacks.picker.actions.close(picker)
          vim.schedule(function()
            if item.dir then
              vim.cmd("Oil " .. item.file:gsub(" ", "\\ "))
            else
              vim.cmd("Oil " .. item._path:gsub(" ", "\\ "))
              vim.cmd("Oil")
            end
          end)
        end,
        open_neogit = function(picker, item)
          if not item then return end
          Snacks.picker.actions.close(picker)
          Snacks.picker.actions.cd(picker, item)
          local dir = item.dir and item.file or item.cwd
          vim.cmd("Neogit kind=replace cwd=" .. dir)
        end,
        live_grep = function(picker, item)
          if not item then return end
          Snacks.picker.actions.cd(picker, item)
          Snacks.picker.actions.close(picker)
          Snacks.picker.grep({ cwd = item.dir and item.file or item.cwd })
        end,
        grep_multiline = function(picker, item)
          Snacks.picker.actions.cd(picker, item)
          Snacks.picker.actions.close(picker)
          vim.schedule(function()
            grep_multiline(item.dir and item.file or item.cwd)
          end)
        end,
      },
      win = {
        input = {
          keys = {
            ["<C-.>"] = { "toggle_hidden", mode = { "n", "i" } },
            ["<C-->"] = { "open_oil", mode = { "n", "i" } },
            ["<C-n>"] = { "open_neogit", mode = { "n", "i" } },
            ["<C-/>"] = { "live_grep", mode = { "n" , "i" } },
            ["<C-\\>"] = { "grep_multiline", mode = { "n" , "i" } },
            ["<esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },
    scroll = {
      enabled = true,
      filter = function(buf)
        return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false
      end,
    },
    styles = {
      notification_history = {
        height = 0.8,
        width = 0.8,
        wo = {
          winhighlight = "NormalFloat:SnacksNotifierHistory,FloatBorder:WinSeparator",
          wrap = true,
        },
      },
    },
  },
  keys = {
    { "<leader>S", function() Snacks.picker() end, desc = "Snacks Pickers" },

    { "<leader>p", function() Snacks.picker.projects() end, desc = "Project Picker" },
    { "<leader>f", function() Snacks.picker.files() end, desc = "File Picker" },
    { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
    { "<leader><tab>", function() Snacks.picker.buffers({ current = false }) end, desc = "Buffer Picker" },

    { "<leader>l", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>*", function() Snacks.picker.grep_word() end, desc = "Grep Word" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Live Grep" },
    { "<leader>\\", grep_multiline, desc = "Live Grep Multi-line" },

    { "gro", function() Snacks.picker.lsp_symbols() end, desc = "Document Symbols" },
    { "grw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },

    { "<leader>h", function() Snacks.picker.help() end, desc = "Help Picker" },
    { "<leader>r", function() Snacks.picker.resume() end, desc = "Snacks Resume" },
    { "<leader>z", function() Snacks.picker.zoxide() end, desc = "Zoxide Picker" },
    { "z=", function() Snacks.picker.spelling() end, "Spelling Picker"},

    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notifier History" },
    { "<leader>F", function() Snacks.zen.zoom() end, desc = "Zoom Window" },
  }
}
