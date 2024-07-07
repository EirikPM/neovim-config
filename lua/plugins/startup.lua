--return {
--	"startup-nvim/startup.nvim",
--	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
--	opts = {},
--	config = function()
--		require("startup").setup()
--	end,
--}

return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("alpha").setup(require("alpha.themes.theta").config)
	end,
}
