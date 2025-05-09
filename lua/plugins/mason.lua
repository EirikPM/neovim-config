return {
	{
		"williamboman/mason.nvim",
		version = "1.11.0",
		dependencies = {
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = { ensure_installed = { "lua-language-server", "stylua", "rust-analyzer", "ts_ls" } },
			},
			{
				"williamboman/mason-lspconfig.nvim",
				version = "1.32.0",
			},
		},
		opts = {},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		cmd = { "DapInstall", "DapUninstall" },
		opt = {
			ensure_installed = { "codelldb" },
		},
		--	config = function()
		--		require("mason-nvim-dap").setup({
		--			handlers = {
		--				function(config)
		--					require("mason-nvim-dap").default_setup(config)
		--				end,
		--				codelldb = function(config) end,
		--			},
		--		})
		--	end,
	},
}
