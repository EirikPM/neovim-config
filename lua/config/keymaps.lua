-- This file is automatically loaded by lazyvim.config.init

local set = vim.keymap.set
local git_changes = require("git_changes")

set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
set("n", "<C-u>", "<C-u>zz", { desc = "scroll up and center" })
set("n", "<C-d>", "<C-d>zz", { desc = "scroll down and center" })
set("n", "]g", function() vim.diagnostic.goto_next() end, {})
set("n", "[g", function() vim.diagnostic.goto_prev() end, {})

set("n", "<leader>gqa", function() git_changes.open("all") end, { desc = "Git Changes: All" })
set("n", "<leader>gqs", function() git_changes.open("staged") end, { desc = "Git Changes: Staged" })
set("n", "<leader>gqu", function() git_changes.open("unstaged") end, { desc = "Git Changes: Unstaged" })

-- Copy filename
vim.keymap.set("n", "<leader>fn", function()
	local filename = vim.fn.expand("%:t")
	vim.fn.setreg("+", filename)
	vim.notify("Copied filename: " .. filename)
end, { desc = "Copy filename" })

-- Copy relative filepath
vim.keymap.set("n", "<leader>fy", function()
	local filepath = vim.fn.expand("%")
	vim.fn.setreg("+", filepath)
	vim.notify("Copied path: " .. filepath)
end, { desc = "Copy file path" })

-- better indenting
set("v", "<", "<gv")
set("v", ">", ">gv")
