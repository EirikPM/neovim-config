return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>fb",
			function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
			mode = "",
			desc = "Format Buffer",
		},
	},
	opts = function()
		return {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				terraform = { "terraform_fmt" },
				hcl = { "terragrunt_hclfmt" },
				proto = { "buf" },
				json = { "jq" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
			},
			format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
			formatters = {
				prettierd = {
					require_cwd = true,
					cwd = require("conform.util").root_file({
						".prettierrc",
						".prettierrc.json",
						".prettierrc.yml",
						".prettierrc.yaml",
						".prettierrc.json5",
						".prettierrc.js",
						".prettierrc.cjs",
						".prettierrc.mjs",
						".prettierrc.toml",
						"prettier.config.js",
						"prettier.config.cjs",
						"prettier.config.mjs",
					}),
				},
			},
		}
	end,
}
