return {
	"folke/todo-comments.nvim",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Move Todo to Quickfix list" },
		{ "<leader>tl", "<cmd>TodoLocList<cr>", desc = "Move Todo to Location list" },
		{ "<leader>tf", "<cmd>TodoTelescope<cr>", desc = "Search project Todos" },
	},
	opts = {},
}
