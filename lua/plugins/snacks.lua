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
		scratch = { enabled = true },
		scope = {},
		picker = { enabled = true },
	},
	keys = {
		-- find
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
		{
			"<leader>fc",
			function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
			desc = "Find Config Files",
		},
		-- search
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix list" },
		{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		-- LSP
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
		{ "<leader>gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
		-- Other
		{ "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
		{ "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
		{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
	},

	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function() Snacks.toggle.inlay_hints():map("<leader>uh") end,
		})
	end,
}
