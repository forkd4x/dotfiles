local function parrot_status()
  if (
    require("lazy.core.config").plugins["parrot.nvim"]._.loaded == nil
    or vim.o.columns < 80
  ) then
    return ""
  end
  local info = require("parrot.config").get_status_info()
  local model = string.gsub(info.model, "^[^/]+/", "")
  model = model:gsub("^claude%-", "")
  model = model:gsub("-20[0-9]+", "")
  return model
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_b = { "branch", "diff" },
      lualine_x = {
        {
          "macro-recording",
          fmt = function()
            if vim.fn.reg_recording() == "" then return "" end
            return "Recording @" .. vim.fn.reg_recording()
          end,
        },
        "selectioncount",
        "searchcount",
        { parrot_status, color = "Label" },
        "diagnostics",
        "filetype",
      },
      lualine_z = {
        {
          "location",
          fmt = function()
            local line = vim.fn.line('.')
            local total_lines = vim.fn.line('$')
            local col = vim.fn.col('.')
            local line_length = vim.fn.col('$') - 1
            return string.format('%d/%d:%d/%d', line, total_lines, col, line_length)
          end,
        },
      },
    },
  },
}
