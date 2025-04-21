-- Copy to system clipboard with OSC52 without requiring read-clipboard
local function paste()
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

return {
	"gbprod/yanky.nvim",
	dependencies = {
		"kkharji/sqlite.lua",
		"folke/snacks.nvim",
	},
	opts = {
		ring = {
			storage = "sqlite",
		},
	},
	keys = {
		{ "y", mode = { "n", "x" }, [[<Plug>(YankyYank)]] },
		{ "p", mode = { "n", "x" }, [[<Plug>(YankyPutAfter)]] },
		{ "P", mode = { "n", "x" }, [[<Plug>(YankyPutBefore)]] },
		{ "=p", mode = { "n", "x" }, [[<Plug>(YankyPutAfterFilter)]] },
		{ "=P", mode = { "n", "x" }, [[<Plug>(YankyPutBeforeFilter)]] },
		{ "[p", [[<Plug>(YankyCycleForward)]], desc = "Previous Yank" },
		{ "]p", [[<Plug>(YankyCycleBackward)]], desc = "Next Yank" },
		{ "<leader>y", [[<cmd>YankyRingHistory<cr>]], desc = "Yanky History" },
		{ "<A-y>", mode = { "n", "x" }, [["+y]], desc = "Yank to clipboard" },
		{ "<A-y><A-y>", [[<A-y>il]], remap = true, desc = "Yank line to clipboard" },
	},
}
