return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  opts = {
    global_keymaps = true,
    additional_curl_options = { "-L" },
    ui = {
      default_view = "headers_body",
    },
  },
  keys = {
    { "<leader>Rb", desc = "Open scratchpad" },
  },
}
