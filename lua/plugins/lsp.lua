return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		{ "saghen/blink.cmp" },
	},
	opts = function()
		local icons = require("lazyvim.config").icons
		---@class PluginLspOpts
		local ret = {
			---@type vim.diagnostics.opts
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
						[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
						[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
						[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
					},
				},
			},

			---@type lspconfig.options
			servers = {
				lua_ls = {},
				elixirls = {},
				html = {},
				tailwindcss = {},
				ts_ls = {},
				eslint = {},
			},
		}
		return ret
	end,
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

		-- diagnostics signs
		if vim.fn.has("nvim-0.10.0") == 0 then
			if type(opts.diagnostics.signs) ~= "boolean" then
				for severity, icon in pairs(opts.diagnostics.signs.text) do
					local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
					name = "DiagnosticSign" .. name
					vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
				end
			end
		end

		if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
			opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
				or function(diagnostic)
					local icons = require("lazyvim.config").icons
					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
					end
				end
		end

		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
	end,
}
