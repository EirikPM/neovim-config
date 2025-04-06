return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false, -- This plugin is already lazy
		config = function()
			local mason_registry = require("mason-registry")

			local codelldb = mason_registry.get_package("codelldb")
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local this_os = vim.uv.os_uname().sysname
			-- The liblldb extension is .so for Linux and .dylib for MacOS
			-- TODO: Make this dynamic
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so" --[[ .. (this_os == "Linux" and ".so" or ".dylib") ]]

			local cfg = require("rustaceanvim.config")
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(client, bufnr)
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end,
					default_settings = {
						["rust-analyzer"] = {},
					},
				},
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
		end,
	},
	{
		"cordx56/rustowl",
		build = "cd rustowl && cargo install --path . --locked",
		lazy = false, -- This plugin is already lazy
		opts = {
			client = {
				on_attach = function(_, buffer)
					vim.keymap.set("n", "<leader>o", function()
						require("rustowl").toggle(buffer)
					end, { buffer = buffer, desc = "Toggle RustOwl" })
				end,
			},
		},
	},
	{
		{
			"saecki/crates.nvim",
			tag = "stable",
			event = { "BufRead Cargo.toml" },
			config = function()
				local crates = require("crates")
				crates.setup({
					lsp = {
						enabled = true,
						actions = true,
						completion = true,
						hover = true,
					},
					-- completion = {
					-- 	cmp = {
					-- 		enabled = true,
					-- 	},
					-- },
				})

				-- Keymaps
				vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Show Crate Features" })
			end,
		},
	},
}
