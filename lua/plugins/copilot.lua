return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = true,
		},
		keys = {
			{ "<leader>cm", "<cmd>CopilotChatCommitStaged<cr>", desc = "Generate commit message staged files" },
			{ "<leader>cc", "<cmd>CopilotChatOpen<cr>", desc = "Open Copilot chat" },
			{ "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Copilot Explain current selection" },
			{ "<leader>cd", "<cmd>CopilotChatDocs<cr>", desc = "Copilot document current selection" },
			{ "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "Copilot Optimzie selected code" },
		},
	},
}
