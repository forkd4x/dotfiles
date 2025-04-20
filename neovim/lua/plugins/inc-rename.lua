return {
	"smjonas/inc-rename.nvim", event = "LspAttach",
	config = function()
		require("inc_rename").setup({})
		vim.keymap.set("n", "grn", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { expr = true, desc = "LSP Rename" })
	end,
}
