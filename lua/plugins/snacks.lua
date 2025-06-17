return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		indent = { enabled = true },
		statuscolumn = { enabled = true },
		scroll = { enabled = true },
		animate = { enabled = true },
		gitbrowse = { enabled = true },
		picker = { enabled = true },
	},
	keys = {
		-- find
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		-- search
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix list" },
		{ "<leader>fc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		-- LSP
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
	},
}
