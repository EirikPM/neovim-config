local function toggle_diffview(cmd)
	if next(require("diffview.lib").views) == nil then
		vim.cmd(cmd)
	else
		vim.cmd("DiffviewClose")
	end
end

return {
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with "keys" is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"sindrets/diffview.nvim",
		command = "DiffviewOpen",
		-- cond = is_git_root,
		keys = {
			{
				"<leader>gd",
				function()
					toggle_diffview("DiffviewOpen")
				end,
				desc = "Diff Index",
			},
			{
				"<leader>gD",
				function()
					toggle_diffview("DiffviewOpen master..HEAD")
				end,
				desc = "Diff master",
			},
			{
				"<leader>gf",
				function()
					toggle_diffview("DiffviewFileHistory %")
				end,
				desc = "Open diffs for current File",
			},
		},
		-- config = function()
		-- 	vim.keymap.set("n", "<leader><leader>v", function()
		-- 		if next(require("diffview.lib").views) == nil then
		-- 			vim.cmd("DiffviewOpen")
		-- 		else
		-- 			vim.cmd("DiffviewClose")
		-- 		end
		-- 	end)
		-- end,
	},
}
