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
		{ "y", mode = {"n", "x"}, [[<Plug>(YankyYank)]] },
		{ "p", mode = {"n", "x"}, [[<Plug>(YankyPutAfter)]] },
		{ "P", mode = {"n", "x"}, [[<Plug>(YankyPutBefore)]] },
		{ "=p", mode = {"n", "x"}, [[<Plug>(YankyPutAfterFilter)]] },
		{ "=P", mode = {"n", "x"}, [[<Plug>(YankyPutBeforeFilter)]] },
		{ "[p", [[<Plug>(YankyCycleForward)]], desc = "Previous Yank" },
		{ "]p", [[<Plug>(YankyCycleBackward)]], desc = "Next Yank" },
		{ "<leader>y", [[<cmd>YankyRingHistory<cr>]], desc = "Yanky History" },
	},
}
