return {
  "sainnhe/gruvbox-material",
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_foreground = "mix"
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
    vim.g.gruvbox_material_better_performance = 1
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        if vim.g.colors_name ~= "gruvbox-material" then return end
        vim.api.nvim_set_hl(0, "@function.builtin", { link = "YellowBold" })
        vim.api.nvim_set_hl(0, "@markup.heading", { bold = true })
        vim.api.nvim_set_hl(0, "@property", { link = "Fg" })
        vim.api.nvim_set_hl(0, "@punctuation.special.htmldjango", { link = "Purple" })
        vim.api.nvim_set_hl(0, "@tag.attribute.html", { link = "Yellow" })
        vim.api.nvim_set_hl(0, "@tag.delimiter.html", { link = "Ignore" })
        vim.api.nvim_set_hl(0, "@tag.html", { link = "Red" })
        vim.api.nvim_set_hl(0, "@variable.builtin", { italic = true })
        vim.api.nvim_set_hl(0, "@variable.member", { link = "Fg" })
        vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticUnderlineHint" })
        vim.api.nvim_set_hl(0, "MatchParen", { link = "FloatTitle" })
        vim.api.nvim_set_hl(0, "NeogitHunkHeaderCursor", { link = "TabLine" })
        vim.api.nvim_set_hl(0, "TabLineFill", { link = "PmenuExtra" })
      end,
    })
    vim.cmd.colorscheme("gruvbox-material")
  end,
}
