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
		picker = {
			enabled = true,
			sources = {
				lsp_references = { include_declaration = false, auto_confirm = false },
				lsp_incoming_calls = { auto_confirm = false },
				lsp_outgoing_calls = { auto_confirm = false },
				files = {
					exclude = { "**/target/**" },
				},
			},
		},
	},
	keys = {
		-- find
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{
			"<leader>fF",
			function()
				local dir = vim.fn.expand("%:p:h")
				Snacks.picker.files({
					cwd = vim.fs.root(dir, { { "Cargo.toml", "package.json" } }) or dir,
				})
			end,
			desc = "Find Files (app/crate)",
		},
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
		{
			"<leader>fc",
			function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
			desc = "Find Config Files",
		},
		-- search
		{
			"<leader>sw",
			function() Snacks.picker.grep_word() end,
			mode = { "n", "x" },
			desc = "Search word or selection",
		},
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo history" },
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix list" },
		{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
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
