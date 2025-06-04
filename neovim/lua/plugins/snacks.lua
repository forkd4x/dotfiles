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
      },
      matcher = {
        frecency = true,
      },
      actions = {
        open_neogit = function(picker, item)
          if not item then return end
          Snacks.picker.actions.cd(picker, item)
          Snacks.picker.actions.close(picker)
          local dir = item.dir and item.file or item.cwd
          vim.cmd("Neogit kind=replace cwd=" .. dir)
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
        end
      },
      win = {
        input = {
          keys = {
            ["<esc>"] = { "close", mode = { "n", "i" } },
            ["<C-.>"] = { "toggle_hidden", mode = { "n", "i" } },
            ["<C-n>"] = { "open_neogit", mode = { "n", "i" } },
            ["<C-->"] = { "open_oil", mode = { "n", "i" } },
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

    { "<leader>p", function() Snacks.picker.projects({ layout = { preview = false } }) end, desc = "Project Picker" },
    { "<leader>P", function()
        if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t") == "main.shada" then
          vim.cmd("write")
          vim.cmd("rshada!")
          vim.cmd("bwipeout!")
        else
          vim.cmd("edit ~/.local/state/nvim/shada/main.shada")
          vim.fn.setreg("d", "Vaikdn")
          vim.notify("Clean-up macro saved to `d` register")
        end
      end, desc = "Edit ShaDa" },

    { "<leader>f", function() Snacks.picker.files() end, desc = "File Picker" },
    { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
    { "<leader><tab>", function() Snacks.picker.buffers({ current = false }) end, desc = "Buffer Picker" },

    { "<leader>l", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>*", function() Snacks.picker.grep_word() end, desc = "Grep Word" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Live Grep" },

    { "gro", function() Snacks.picker.lsp_symbols() end, desc = "Document Symbols" },
    { "grw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },

    { "<leader>h", function() Snacks.picker.help() end, desc = "Help Picker" },
    { "<leader>r", function() Snacks.picker.resume() end, desc = "Snacks Resume" },
    { "<leader>z", function() Snacks.picker.zoxide() end, desc = "Zoxide Picker" },
    { "z=", function() Snacks.picker.spelling({ layout = { preset = "custom", preview = false } }) end, "Spelling Picker" },
    { "<leader>tT", function() Snacks.picker.todo_comments() end, desc = "Todo Picker" },

    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notifier History" },
    { "<leader>F", function() Snacks.zen.zoom() end, desc = "Zoom Window" },
  }
}
