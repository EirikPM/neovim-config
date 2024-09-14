return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	-- enabled = true,
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fb",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format Buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			toml = { "taplo" },
			terraform = { "terraform_fmt" },
			hcl = { "terragrunt_hclfmt" },
			proto = { "buf" },
			json = { "jq" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
