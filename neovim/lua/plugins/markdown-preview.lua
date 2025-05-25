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
      function()
        vim.cmd("MarkdownPreviewToggle")
        vim.defer_fn(function()
          vim.api.nvim_command("redrawstatus")
        end, 50)
       end,
      desc = "Markdown Preview",
    },
  },
}
