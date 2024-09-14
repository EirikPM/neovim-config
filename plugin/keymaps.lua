local set = vim.keymap.set

set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
set("n", "<C-u>", "<C-u>zz", { desc = "scroll up and center" })
set("n", "<C-d>", "<C-d>zz", { desc = "scroll down and center" })
set("n", "]g", function()
	vim.diagnostic.goto_next()
end, {})
set("n", "[g", function()
	vim.diagnostic.goto_prev()
end, {})
