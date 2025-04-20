return {
	"chrisgrieser/nvim-scissors",
	opts = {
		jsonFormatter = "jq",
		backdrop = { enabled = false },
	},
	keys = {
		{ "<leader>sa", mode = { "n", "x" }, [[<cmd>ScissorsAddNewSnippet<cr>]], desc = "Add" },
		{ "<leader>se", [[<cmd>silent ScissorsEditSnippet<cr>]], desc = "Edit" },
	},
}
