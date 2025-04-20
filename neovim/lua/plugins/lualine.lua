return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_b = { "branch", "diff" },
			lualine_x = {
				{ "macro-recording",
					fmt = function()
						if vim.fn.reg_recording() == "" then return "" end
						return "Recording @" .. vim.fn.reg_recording()
					end,
				},
				"selectioncount", "searchcount", "diagnostics", "filetype",
			},
		},
	},
}
