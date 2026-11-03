return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
		"folke/snacks.nvim",
	},
	opts = {
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		},
		servers = {
			lua_ls = {},
			elixirls = {},
			html = {},
			tailwindcss = {},
			ts_ls = {},
			eslint = {},
		},
	},
	config = function(_, opts)
		vim.diagnostic.config(opts.diagnostics)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
			callback = function(event)
				local function map(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc }) end
				map("K", vim.lsp.buf.hover, "Hover documentation")
				map("gd", function() Snacks.picker.lsp_definitions() end, "Goto definition")
				map("gD", function() Snacks.picker.lsp_declarations() end, "Goto declaration")
				map("grr", function() Snacks.picker.lsp_references() end, "References")
				map("gri", function() Snacks.picker.lsp_implementations() end, "Goto implementation")
				map("grt", function() Snacks.picker.lsp_type_definitions() end, "Goto type definition")
				map("<leader>ci", function() Snacks.picker.lsp_incoming_calls() end, "Incoming calls")
				map("<leader>co", function() Snacks.picker.lsp_outgoing_calls() end, "Outgoing calls")
				map("<leader>ss", function() Snacks.picker.lsp_symbols() end, "Document symbols")
				map("<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "Workspace symbols")
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
					buffer = event.buf,
					desc = "Code action",
				})
			end,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)
		for server, config in pairs(opts.servers) do
			vim.lsp.config(server, vim.tbl_extend("force", config, { capabilities = capabilities }))
		end
		vim.lsp.enable(vim.tbl_keys(opts.servers))
	end,
}
