return {
	"folke/lazydev.nvim", ft = "lua",
	dependencies = "Bilal2453/luvit-meta",
	opts = {
		library = {
			"lazy.nvim",
			"snacks.nvim",
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
			{ path = "~/.config/hammerspoon/Spoons/EmmyLua.spoon/annotations" },
		},
	},
}
