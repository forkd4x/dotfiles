return {
  "nvim-mini/mini.nvim",
  config = function()
    local gen_ai_spec = require("mini.extra").gen_ai_spec
    require("mini.ai").setup({
      custom_textobjects = {
        g = gen_ai_spec.buffer(),
        i = gen_ai_spec.indent(),
        l = gen_ai_spec.line(),
        n = gen_ai_spec.number(),
      },
      mappings = {
        around_next = "",
        inside_next = "",
        around_last = "",
        inside_last = "",
      },
      n_lines = 1000,
    })

    require("mini.align").setup({
      mappings = {
        start_with_preview = "ga",
      },
      -- Align only first column of "=" by default
      modifiers = {
        ["="] = function(steps, opts)
          opts.split_pattern = "%p*=+[<>~]*"
          table.insert(steps.pre_justify, MiniAlign.gen_step.trim())
          table.insert(steps.pre_justify, MiniAlign.gen_step.filter("n==1"))
          opts.merge_delimiter = " "
        end,
      },
    })

    require("mini.bracketed").setup({
      comment = { suffix = "" },    -- treesitter Class/conditional
      file = { suffix = "" },       -- treesitter function
      location = { suffix = "" },   -- treesitter loop
      treesitter = { suffix = "" }, -- todo-comment
    })

    require("mini.clue").setup({
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        -- Built-in completion
        { mode = "i", keys = "<C-x>" },
        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "gc" }, -- Fix `gcc` on remote servers
        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        -- Window commands
        { mode = "n", keys = "<C-w>" },
        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
        -- Prev/Next commands
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
      },
      clues = {
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.marks(),
        require("mini.clue").gen_clues.registers(),
        require("mini.clue").gen_clues.windows(),
        require("mini.clue").gen_clues.z(),
        { mode = "n", keys = "<leader>a", desc = "+AI" },
        { mode = "n", keys = "<leader>d", desc = "+Diagnostics" },
        { mode = "n", keys = "<leader>g", desc = "+Git" },
        { mode = "n", keys = "<leader>R", desc = "+Kulala" },
        { mode = "n", keys = "<leader>s", desc = "+Snippets" },
        { mode = "n", keys = "<leader>t", desc = "+Todo" },
      },
      window = {
        config = {
          border = "rounded",
        },
      },
    })
    vim.api.nvim_set_hl(0, "MiniClueBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "MiniClueDescGroup", { link = "Special" })
    vim.api.nvim_set_hl(0, "MiniClueDescSingle", { link = "Normal" })
    vim.api.nvim_set_hl(0, "MiniClueNextKey" , { link = "Normal"})
    vim.api.nvim_set_hl(0, "MiniClueNextKeyWithPostkeys" , { link = "Normal"})
    vim.api.nvim_set_hl(0, "MiniClueSeparator" , { link = "Normal"})
    vim.api.nvim_set_hl(0, "MiniClueTitle" , { link = "Title"})

    require("mini.icons").setup()

    require("mini.pairs").setup({
      mappings = {
        ['"'] = { neigh_pattern = "[^\\%a%d\"'][^\\%a%d\"']", register = { cr = true } },
        ["'"] = { neigh_pattern = "[^\\%a%d\"'][^\\%a%d\"']", register = { cr = true } },
      }
    })
    -- Fix <cr> between tags indenting properly
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "html", "htmldjango", "phtml", "templ", "xml" },
      callback = function()
        vim.keymap.set("i", "<cr>", "<cr><esc>O", { buffer = vim.api.nvim_get_current_buf() })
      end,
    })

    require("mini.surround").setup({
      mappings = {
        add = "gs",
        delete = "ds",
        find = "gsl",
        find_left = "gsh",
        highlight = "",
        replace = "cs",
        update_n_lines = "",
      },
      n_lines = 1000,
    })
    vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], { silent = true })
    vim.keymap.set("n", "gss", "gs_", { remap = true, desc = "Surround line" })

  end,
}
