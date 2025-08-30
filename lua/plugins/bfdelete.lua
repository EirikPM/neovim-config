return {
	"bfdelete.nvim",
	dir = vim.fn.stdpath("config") .. "/lua/bfdelete",
	lazy = false,
	config = function() require("bfdelete") end,
}
