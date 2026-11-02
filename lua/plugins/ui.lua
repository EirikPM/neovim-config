return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
			},
		},
	},
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		config = function() require("alpha").setup(require("alpha.themes.theta").config) end,
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},
}
