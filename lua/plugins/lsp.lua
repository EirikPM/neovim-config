return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local set = vim.keymap.set
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local snippet_capabilites = vim.lsp.protocol.make_client_capabilities()
		snippet_capabilites.textDocument.completion.completionItem.snippetSupport = true
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
		})
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
		})
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
		})
		lspconfig.html.setup({
			capabilities = snippet_capabilites,
		})
		lspconfig.eslint.setup({
			settings = {
				packageManager = "yarn",
			},
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
		})
		--		lspconfig.rust_analyzer.setup({
		--			capabilities = capabilities,
		--		})

		-- Keymaps
		set("n", "K", vim.lsp.buf.hover, {})
		set("n", "gD", vim.lsp.buf.definition, {})
		set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
	end,
}
