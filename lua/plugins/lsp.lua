return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local set = vim.keymap.set
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
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
