return {
  "saghen/blink.cmp",
  version = 'v0.*',
  event = "InsertEnter",
  config = function()
    require("blink-cmp").setup({
      keymap = {
        preset = "super-tab",
        ["<C-k>"] = {},
        ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      sources = {
        providers = {
          buffer = { score_offset = -7 },
          lsp = { fallbacks = {} }, -- Always show buffer items
        },
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        documentation = { auto_show = true },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      signature = { enabled = true },
    })
  end,
}
