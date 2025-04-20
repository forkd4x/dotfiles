return {
	"aznhe21/actions-preview.nvim",
	opts = {
		backend = { "snacks" },
		snacks = {
			layout = { preset = "custom" },
		},
	},
	keys = {
		{ "gra", function() require("actions-preview").code_actions() end, desc = "Code Actions" },
	},
}
