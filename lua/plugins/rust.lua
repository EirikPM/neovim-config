return {
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false, -- rustaceanvim handles loading for Rust buffers itself.
		dependencies = { "saghen/blink.cmp" },
		init = function()
			vim.g.rustaceanvim = function()
				return {
					server = {
						capabilities = require("blink.cmp").get_lsp_capabilities(),
						on_attach = function(_, bufnr)
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							for key, action in pairs({
								["<leader>rr"] = { "runnables", "Rust run target" },
								["<leader>rt"] = { "testables", "Rust run tests" },
								["<leader>re"] = { "explainError", "Rust explain error" },
								["<leader>rm"] = { "expandMacro", "Rust expand macro" },
							}) do
								vim.keymap.set("n", key, function() vim.cmd.RustLsp(action[1]) end, {
									buffer = bufnr,
									desc = action[2],
								})
							end
							vim.keymap.set("n", "<leader>dr", function() vim.cmd.RustLsp("debuggables") end, {
								buffer = bufnr,
								desc = "Rust Debuggables",
							})
						end,
						default_settings = {
							["rust-analyzer"] = {
								-- bacon-ls owns compiler diagnostics; avoid duplicate reports.
								checkOnSave = false,
								diagnostics = { enable = false },
							},
						},
					},
				}
			end
		end,
	},
	{
		"neovim/nvim-lspconfig",
		-- Extends the servers table consumed by your existing plugins/lsp.lua.
		opts = function(_, opts)
			opts.servers = opts.servers or {}
			opts.servers.bacon_ls = {
				-- Share one Bacon client across members of the same Cargo workspace.
				root_dir = vim.lsp.config.rust_analyzer.root_dir,
				init_options = { cargo = { updateOnInsert = false } },
				settings = {
					bacon_ls = {
						backend = "cargo",
						cargo = {
							command = "check",
							checkOnSave = true,
							allTargets = true,
							extraArgs = { "--workspace" },
							-- Finish a running check and queue the latest save.
							cancelRunning = false,
						},
					},
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		event = { "BufRead Cargo.toml", "BufNewFile Cargo.toml" },
		opts = {
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
		keys = {
			{
				"<leader>cf",
				function() require("crates").show_features_popup() end,
				desc = "Show Crate Features",
			},
		},
	},
}
