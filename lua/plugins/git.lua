local function toggle_diffview(cmd)
	if next(require("diffview.lib").views) == nil then
		vim.cmd(cmd)
	else
		vim.cmd("DiffviewClose")
	end
end

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
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewFileHistory",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
		},
		keys = {
			{ "<leader>gd", function() toggle_diffview("DiffviewOpen") end, desc = "Diff Index" },
			{ "<leader>gD", function() toggle_diffview("DiffviewOpen master..HEAD") end, desc = "Diff master" },
			{
				"<leader>gf",
				function() toggle_diffview("DiffviewFileHistory %") end,
				desc = "Open diffs for current File",
			},
		},
	},
}
