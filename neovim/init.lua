vim.g.mapleader = " "

vim.o.cmdheight = 0
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.formatoptions = "crqnlj"
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.pumheight = 7
vim.o.scrolloff = 5
vim.o.shiftwidth = 4
vim.o.sidescrolloff = 5
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.textwidth = 88
vim.o.title = true
vim.o.titlestring = "(%{hostname()}) %{fnamemodify(getcwd(), ':t')}"
vim.o.wrap = false

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "https://github.com/folke/lazy.nvim.git",
    "--filter=blob:none", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(
  { import = "plugins" },
  { change_detection = { enabled = false } }
)
vim.keymap.set("n", "<leader>L", [[<cmd>Lazy<cr>]], { desc = "Lazy.nvim" })

-- Exit insert mode
vim.keymap.set("i", "jk", "<esc>")

-- Clear search highlights
vim.keymap.set("n", "<esc>", [[<cmd>nohlsearch<cr>]])

-- Search in visual selection
vim.keymap.set("x", "//", "<Esc>/\\%V")

-- Select last changed or pasted region
vim.keymap.set("n", "gp", [[ "`[" . getregtype() . "`]" ]], {
  expr = true, desc = "Select last paste"
})

-- Fix j/k movements in wrapped lines
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Use Cmd+j/k in command completion popups
vim.keymap.set("c", "<up>",   "<C-p>", { remap = true })
vim.keymap.set("c", "<down>", "<C-n>", { remap = true })

-- Delete buffer without saving/prompt
vim.keymap.set("n", "<leader>k", [[<cmd>bw!<cr>]], { desc = "Wipe Buffer" })
vim.keymap.set("n", "<leader>K", [[<cmd>b#|bw! #<cr>]], { desc = "Wipe Buffer Split" })

-- Send to terminal
vim.keymap.set({ "n", "x" }, "<leader><leader>", function()
  if vim.fn.mode() == "n" then vim.cmd([[normal V]]) end
  vim.cmd([[normal "vy]])
  local data = vim.fn.shellescape("\x1b[200~" .. vim.fn.getreg("v") .. "\x1b[201~\n")
  os.execute("printf '%s' " .. data .. " | kitty @ send-text --match recent:1 --stdin")
end, { desc = "Send to Terminal" })

-- Exit quickly without prompts
vim.keymap.set({ "n", "x" }, "Q", [[<cmd>qa!<cr>]]) -- Without saving
vim.keymap.set({ "n", "x" }, "Z", [[<cmd>xa!<cr>]]) -- Save if modified
