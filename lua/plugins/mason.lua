return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = { ensure_installed = { "lua-language-server", "stylua", "rust-analyzer" } },
			},
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			ensure_installed = { "codelldb" },
		},
	},
}
