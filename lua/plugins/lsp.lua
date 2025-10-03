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
		local set = vim.keymap.set

		-- Capabilities (blink.cmp + snippets)
		local caps = vim.lsp.protocol.make_client_capabilities()
		caps.textDocument.completion.completionItem.snippetSupport = true
		caps = require("blink.cmp").get_lsp_capabilities(caps)

		-- Register/merge per-server configs
		for server, conf in pairs(opts.servers) do
			conf = vim.deepcopy(conf or {})
			conf.capabilities = caps

			-- Merge into the server's default config
			-- You can also do: vim.lsp.config(server, conf)
			vim.lsp.config[server] = vim.tbl_deep_extend("force", vim.lsp.config[server] or {}, conf)
		end

		-- Enable all configured servers (autostarts on matching buffers)
		-- You can pass a list, or call per server.
		vim.lsp.enable(vim.tbl_keys(opts.servers))

		-- Buffer-local keymaps on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local buf = ev.buf
				set("n", "K", vim.lsp.buf.hover, { buffer = buf })
				set("n", "gD", vim.lsp.buf.definition, { buffer = buf })
				set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf })
			end,
		})

		-- Diagnostic signs (keep your existing behavior)
		if vim.fn.has("nvim-0.10.0") == 0 then
			if type(opts.diagnostics.signs) ~= "boolean" then
				for severity, icon in pairs(opts.diagnostics.signs.text) do
					local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
					name = "DiagnosticSign" .. name
					vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
				end
			end
		end

		-- Icons in virtual text
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
