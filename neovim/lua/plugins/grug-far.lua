return {
	"MagicDuck/grug-far.nvim",
	config = true,
	keys = {
		{ "<leader>?", mode = "n", [[<cmd>GrugFar<cr>]], desc ="GrugFar" },
		{ "<leader>?", mode = "x", [[:GrugFarWithin<cr>]], desc ="GrugFar Within" },
		{ "<leader>*", mode = "x", [[:GrugFar<cr>]], desc = "GrugFar Selection" },
	}
}
