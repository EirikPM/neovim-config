return {
	{ "norcalli/nvim-base16.lua" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"olivercederborg/poimandres.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"sho-87/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "rebelot/kanagawa.nvim", priority = 1000 },
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
	},

	{
		"anAcc22/sakura.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"paradise-theme/paradise",
		lazy = false,
		priority = 1000,
	},
	{
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"zenbones-theme/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	{
		"embark-theme/vim",
		lazy = false,
		priority = 1000,
		name = "embark",
	},
	{
		"kryptamine/gruber-darker-renaissance",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruber-darker-renaissance").setup({})
			vim.cmd.colorscheme("gruber-darker-renaissance")
		end,
	},
}
