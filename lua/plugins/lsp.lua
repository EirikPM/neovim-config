return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		{ "saghen/blink.cmp" },
	},
	opts = {
		servers = {
			lua_ls = {},
			html = {},
			tailwindcss = {},
			ts_ls = {},
			eslint = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local set = vim.keymap.set
		-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local snippet_capabilites = vim.lsp.protocol.make_client_capabilities()
		snippet_capabilites.textDocument.completion.completionItem.snippetSupport = true

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(snippet_capabilites)
			lspconfig[server].setup(config)
		end

		-- Keymaps
		set("n", "K", vim.lsp.buf.hover, {})
		set("n", "gD", vim.lsp.buf.definition, {})
		set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
	end,
	--
	-- lspconfig.lua_ls.setup({
	-- 	capabilities = capabilities,
	-- })
	-- lspconfig.ts_ls.setup({
	-- 	capabilities = capabilities,
	-- })
	-- lspconfig.tailwindcss.setup({
	-- 	capabilities = capabilities,
	-- })
	-- lspconfig.html.setup({
	-- 	capabilities = snippet_capabilites,
	-- })
	-- lspconfig.pyright.setup({
	-- 	capabilities = capabilities,
	-- })
	-- lspconfig.eslint.setup({
	-- 	settings = {
	-- 		packageManager = "yarn",
	-- 	},
	-- 	on_attach = function(client, bufnr)
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			buffer = bufnr,
	-- 			command = "EslintFixAll",
	-- 		})
	-- 	end,
	-- })
	--		lspconfig.rust_analyzer.setup({
	--			capabilities = capabilities,
	--		})
}
