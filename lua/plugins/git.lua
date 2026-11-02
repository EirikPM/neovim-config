return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		keys = {
			{ "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
			{ "<leader>ghi", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview hunk inline" },
			{ "<leader>ghn", "<cmd>Gitsigns nav_hunk next<cr>", desc = "Next hunk" },
			{ "<leader>ghN", "<cmd>Gitsigns nav_hunk prev<cr>", desc = "Previous hunk" },
			{ "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage/unstage hunk" },
			{ "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Discard hunk changes" },
			{ "<leader>ghd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff current file" },
			{ "<leader>ghb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame current line" },
			{ "<leader>ghB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
		},
		opts = {},
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"esmuellert/codediff.nvim",
		version = "^4.0.0",
		cmd = "CodeDiff",
		keys = {
			{ "<leader>gd", "<cmd>CodeDiff<cr>", desc = "Git diff" },
			{
				"<leader>gD",
				function()
					vim.ui.input({ prompt = "Compare against branch/revision: " }, function(base)
						if base and vim.trim(base) ~= "" then
							vim.cmd.CodeDiff({ args = { vim.trim(base) .. "..." } })
						end
					end)
				end,
				desc = "Diff against branch",
			},
			{ "<leader>gf", "<cmd>CodeDiff history %<cr>", desc = "File history" },
			{ "<leader>gS", "<cmd>CodeDiff --staged<cr>", desc = "Staged diff" },
		},
	},
}
