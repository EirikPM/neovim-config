return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/snacks.nvim" },
	opts = {
		modes = {
			lsp = {
				win = { position = "bottom" },
			},
			-- diagnostics = {
			-- 	win = { position = "right" },
			-- },
		},
	},
	cmd = "Trouble",
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
	},

	-- "folke/trouble.nvim",
	-- dependencies = { "nvim-tree/nvim-web-devicons", "folke/snacks.nvim" },
	-- opts = {
	-- 	modes = {
	-- 		diagnostics = {
	-- 			win = {
	-- 				position = "right",
	-- 				type = "split",
	-- 				relative = "editor",
	-- 				size = 60,
	-- 			},
	-- 		},
	-- 	},
	-- },
	-- cmd = "Trouble",
	-- keys = {
	-- 	{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
	-- 	{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
	-- 	{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
	-- 	{
	-- 		"<leader>cl",
	-- 		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	-- 		desc = "LSP Definitions / references / ... (Trouble)",
	-- 	},
	-- 	{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
	-- 	{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
	-- },
}
