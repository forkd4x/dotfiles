return {
	"echasnovski/mini.nvim",
	config = function()
		local gen_ai_spec = require("mini.extra").gen_ai_spec
		require("mini.ai").setup({
			custom_textobjects = {
				g = gen_ai_spec.buffer(),
				i = gen_ai_spec.indent(),
				l = gen_ai_spec.line(),
				n = gen_ai_spec.number(),
			},
			mappings = {
				around_next = "",
				inside_next = "",
				around_last = "",
				inside_last = "",
			},
			n_lines = 1000,
		})

		require("mini.align").setup({
			mappings = { start = "" }
		})

		require("mini.clue").setup({
			triggers = {
				{ mode = 'n', keys = '<Leader>' },
				{ mode = 'x', keys = '<Leader>' },
				{ mode = 'i', keys = '<C-x>' },
				{ mode = 'n', keys = 'g' },
				{ mode = 'x', keys = 'g' },
				{ mode = 'n', keys = "'" },
				{ mode = 'n', keys = '`' },
				{ mode = 'x', keys = "'" },
				{ mode = 'x', keys = '`' },
				{ mode = 'n', keys = '"' },
				{ mode = 'x', keys = '"' },
				{ mode = 'i', keys = '<C-r>' },
				{ mode = 'c', keys = '<C-r>' },
				{ mode = 'n', keys = '<C-w>' },
				{ mode = 'n', keys = 'z' },
				{ mode = 'x', keys = 'z' },
				{ mode = 'n', keys = '[' },
				{ mode = 'n', keys = ']' },
			},
			clues = {
				require("mini.clue").gen_clues.builtin_completion(),
				require("mini.clue").gen_clues.g(),
				require("mini.clue").gen_clues.marks(),
				require("mini.clue").gen_clues.registers(),
				require("mini.clue").gen_clues.windows(),
				require("mini.clue").gen_clues.z(),
				{ mode = "n", keys = "<leader>a", desc = "+AI" },
				{ mode = "n", keys = "<leader>d", desc = "+Diagnostics" },
				{ mode = "n", keys = "<leader>g", desc = "+Git" },
				{ mode = "n", keys = "<leader>R", desc = "+Kulala" },
				{ mode = "n", keys = "<leader>s", desc = "+Snippets" },
				{ mode = "n", keys = "<leader>t", desc = "+Todo" },
			},
			window = {
				config = {
					border = "rounded",
				},
			},
		})
		vim.api.nvim_set_hl(0, "MiniClueBorder", { link = "Normal" })
		vim.api.nvim_set_hl(0, "MiniClueDescGroup", { link = "Special" })
		vim.api.nvim_set_hl(0, "MiniClueDescSingle", { link = "Normal" })
		vim.api.nvim_set_hl(0, "MiniClueNextKey" , { link = "Normal"})
		vim.api.nvim_set_hl(0, "MiniClueNextKeyWithPostkeys" , { link = "Normal"})
		vim.api.nvim_set_hl(0, "MiniClueSeparator" , { link = "Normal"})
		vim.api.nvim_set_hl(0, "MiniClueTitle" , { link = "Title"})

		require("mini.icons").setup()

		require("mini.jump2d").setup({
			mappings = {
				start_jumping = "",
			},
		})
		vim.keymap.set({ "n", "x" }, "s", function()
			require("mini.jump2d").start(require("mini.jump2d").builtin_opts.single_character)
		end)

		require("mini.pairs").setup({
			mappings = {
				['"'] = { neigh_pattern = "[^\\%a%d\"'][^\\%a%d\"']", register = { cr = true } },
				["'"] = { neigh_pattern = "[^\\%a%d\"'][^\\%a%d\"']", register = { cr = true } },
			}
		})
		-- Fix <cr> between tags indenting properly
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "html", "phtml", "templ", "xml" },
		  callback = function()
		    vim.keymap.set("i", "<cr>", "<cr><esc>O", { buffer = vim.api.nvim_get_current_buf() })
		  end,
		})

		local gen_hook = require("mini.splitjoin").gen_hook
		local curly = { brackets = { '%b{}' } }
		require("mini.splitjoin").setup({
			mappings = {
				toggle = "<leader>j",
			},
			split    = {
				hooks_post = {
					gen_hook.add_trailing_separator(curly),
				},
			},
			join     = {
				hooks_post = {
					gen_hook.del_trailing_separator(curly),
					gen_hook.pad_brackets(curly),
				},
			},
		})

		require("mini.surround").setup({
			mappings = {
				add = "gs",
				delete = "ds",
				find = "gsl",
				find_left = "gsh",
				highlight = "",
				replace = "cs",
				update_n_lines = "",
			},
			n_lines = 1000,
		})
		vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], { silent = true })
		vim.keymap.set("n", "gss", "gs_", { remap = true, desc = "Surround line" })

	end,
}
