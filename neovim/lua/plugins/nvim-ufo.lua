return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("ufo").setup({
      provider_selector = function() return { "treesitter", "indent" } end,
      preview = {
        win_config = {
          border = "none",
          winblend = 0,
          winhighlight = "Normal:NormalFloat",
        },
      },
    })
    vim.schedule(function()
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)

    end)
    vim.api.nvim_set_hl(0, "Folded", {})
    vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { link = "FloatTitle" })
  end,
  keys = {
    {
      "K",
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
    },
    {
      "zc",
      function()
        vim.defer_fn(function()
          vim.cmd([[normal zc]])
          vim.keymap.set("n", "zc", "zc", { desc = "Close fold" })
        end, 100)
      end,
    },
    {
      "zm",
      function()
        local vcount = vim.v.count
        vim.defer_fn(function()
          require("ufo").closeFoldsWith(vcount)
        end, 100)
      end
    },
  },
}
