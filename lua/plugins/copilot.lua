return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			model = "gpt-5",
		},
		keys = {
			{ "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "Toggle CopilotChat" },
			{ "<leader>cp", "<cmd>CopilotChatPrompts<cr>", desc = "View/Select CopilotChat prompts" },
			{ "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "View/Select CopilotChat models" },
		},
	},
}
