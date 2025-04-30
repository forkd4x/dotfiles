return {
  "NeogitOrg/neogit",
  dependencies = "nvim-lua/plenary.nvim",
  init = function()
    vim.api.nvim_create_autocmd("InsertEnter", {
      callback = function()
        if vim.bo.filetype == "NeogitCommitMessage" or vim.bo.filetype == "gitcommit" then
          vim.opt_local.spell = true
        end
      end,
    })
  end,
  config = function()
    require("neogit").setup({
      disable_hint = true,
      disable_insert_on_commit = true,
      console_timeout = 5000,
      graph_style = "kitty",
      sections = {
        untracked = { folded = true, hidden = false },
      },
    })
  end,
  cmd = "Neogit",
  keys = {
    { "<leader>gg", [[<cmd>silent! wa<cr><cmd>Neogit kind=replace<cr>]], desc = "Neogit" },
  },
}
