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
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, "Title"})
        return newVirtText
      end,
    })
    vim.schedule(function()
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    end)
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
