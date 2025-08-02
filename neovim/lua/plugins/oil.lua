return {
  "stevearc/oil.nvim",
  init = function()
    vim.g.loaded_netrwPlugin = 1
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = vim.schedule_wrap(function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if vim.fn.isdirectory(bufname) == 1 then
          vim.cmd("Oil " .. bufname)
        end
      end),
    })
  end,
  config = function()
    require("oil").setup({
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      columns = {
        { "mtime", highlight = "Comment" },
        { "size", highlight = "Blue" },
        { "icon" },
      },
      keymaps = {
        ["<esc>"] = { "actions.close", mode = "n" },
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-p>"] = "actions.preview",
        ["<C-r>"] = "actions.refresh",
        ["<A-y>"] = {
          function()
            vim.fn.setreg("+", require("oil").get_current_dir() .. require("oil").get_cursor_entry().name)
          end, desc = "Copy full file path to clipboard",
        },
        ["~"] = {
          function() require("oil").open(vim.fn.expand("~")) end,
          desc = "Jump to home directory",
        },
        ["Q"] = {
          function()
            local file = io.open("/tmp/.oil.nvim.cd", "w")
            if file ~= nil then
              file:write(require("oil").get_current_dir())
              file:close()
            end
            vim.cmd("qa!")
          end, desc = "Exit Neovim to current directory",
        },
      },
      win_options = { winbar = "%{v:lua.require('oil').get_current_dir()}" },
    })
    vim.api.nvim_set_hl(0, "WinBar", { link = "Title" })
  end,
  cmd = "Oil",
  keys = {{"-", [[<cmd>Oil<cr>]] }},
}
