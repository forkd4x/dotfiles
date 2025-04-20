return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("ufo").setup({
			provider_selector = function() return { "treesitter", "indent" } end,
		})
		vim.schedule(function()
			vim.keymap.del("n", "zc")
			vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)

		end)
		vim.api.nvim_set_hl(0, "Folded", {})
		vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { link = "FloatTitle" })
	end,
	keys = {
		{
			"zc",
			function() vim.defer_fn(function() vim.cmd([[normal zc]]) end, 100) end,
		},
		{
			"zm",
			function()
				local vcount = vim.v.count
				vim.defer_fn(function() require("ufo").closeFoldsWith(vcount) end, 100)
			end
		},
	},
}
