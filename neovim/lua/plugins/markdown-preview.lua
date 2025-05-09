return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  build = [[cd app && npm install && git restore .]],
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.spell = true
        vim.opt_local.wrap = true
      end,
    })
  end,
  keys = {
    {
      "<leader>m",
      [[:MarkdownPreviewToggle<cr>]] .. [[:redrawstatus<cr>]],
      desc = "Markdown Preview",
    },
  },
}
