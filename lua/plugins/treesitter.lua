return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function() require("nvim-treesitter.install").update({ with_sync = true })() end,
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {},
		enabled = false,
	},
}
