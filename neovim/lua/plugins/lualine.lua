local function parrot_status()
  if (
    require("lazy.core.config").plugins["parrot.nvim"]._.loaded == nil
    or vim.o.columns < 80
  ) then
    return ""
  end
  local info = require("parrot.config").get_status_info()
  local is_chat = info.is_chat and "chat" or "command"
  local provider = info.prov[is_chat].name
  local model = string.gsub(info.model, "-20[0-9]+", "")
  local thinking = require("parrot.config").chat_handler.providers[provider].params[is_chat].thinking
  return string.format("{%s%s}", model, thinking and "[think]" or "")
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
    },
  },
}
