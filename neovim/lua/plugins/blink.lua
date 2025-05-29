return {
  "saghen/blink.cmp",
  version = '1.*',
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    require("blink-cmp").setup({
      keymap = {
        preset = "super-tab",
        ["<C-k>"] = {},
        ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        documentation = { auto_show = true },
      },
      signature = { enabled = true },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          buffer = { score_offset = -7 },
          lsp = { fallbacks = {} }, -- Always show buffer items
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = function()
              return vim.fn.getcmdtype() == ":"
            end,
          },
        },
        keymap = {
          preset = "inherit",
        },
      },
    })

    vim.keymap.set("c", "<C-s>", function()
      local cmd = vim.fn.getcmdline()
      if cmd and cmd ~= "" then
        vim.api.nvim_feedkeys("\27", "n", false) -- Exit command mode
        vim.cmd("help " .. cmd)
      end
    end, { desc = "Show help for command" })
  end,
}
