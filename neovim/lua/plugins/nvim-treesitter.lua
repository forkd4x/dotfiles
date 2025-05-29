return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = { enable = true },
        indent = {
          enable = true,
          disable = { "yaml" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "v",
            node_decremental = "<backspace>",
          },
        },
      })
      -- Use bash treesitter syntax for zsh files
      vim.treesitter.language.register("bash", "zsh")
      vim.keymap.set("n", "<leader>i", [[<cmd>Inspect<cr>]], { desc = "Inspect Syntax" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({ enable = false })
      vim.keymap.set("n", "<leader>`", [[<cmd>TSContextToggle<cr>]], { desc = "Context" })
      vim.keymap.set("n", "[`", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { desc = "Go To Context"})
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["aa"] = "@parameter.outer",   ["ia"] = "@parameter.inner",
              ["aC"] = "@class.outer",       ["iC"] = "@class.inner",
              ["ac"] = "@conditional.outer", ["ic"] = "@conditional.inner",
              ["af"] = "@function.outer",    ["if"] = "@function.inner",
              ["aL"] = "@loop.outer",        ["iL"] = "@loop.inner",
              ["a;"] = "@comment.outer",     ["i;"] = "@comment.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = false,
            goto_next_start = {
              ["]a"] = "@parameter.inner",
              ["]C"] = "@class.outer",
              ["]c"] = "@conditional.outer",
              ["]f"] = "@function.outer",
              ["]l"] = "@loop.outer",
              ["];"] = "@comment.outer",
            },
            goto_previous_start = {
              ["[a"] ="@parameter.inner",
              ["[C"] ="@class.outer",
              ["[c"] ="@conditional.outer",
              ["[f"] ="@function.outer",
              ["[l"] ="@loop.outer",
              ["[;"] ="@comment.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>al"] = "@parameter.inner" },
            swap_previous = { ["<leader>ah"] = "@parameter.inner" },
          },
        },
      })
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    end,
  },
}
