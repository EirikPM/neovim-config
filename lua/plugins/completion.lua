return {
	"hrsh7th/nvim-cmp",
	lazy = false,
	priority = 100,
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
				{ name = "crates" },
				{ name = "path" },
				{ name = "buffer" },
			}),
		})
		-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
		-- Set configuration for specific filetype.
		--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]
		--

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		--		cmp.setup.cmdline(":", {
		--			mapping = cmp.mapping.preset.cmdline(),
		--			sources = cmp.config.sources({
		--				{ name = "path" },
		--			}, {
		--				{ name = "cmdline" },
		--			}),
		--			matching = {
		--				disallow_fuzzy_matching = false,
		--				disallow_partial_matching = false,
		--				disallow_prefix_unmatching = false,
		--				disallow_fullfuzzy_matching = false,
		--				disallow_partial_fuzzy_matching = false,
		--				disallow_symbol_nonprefix_matching = false,
		--			},
		--		})
	end,
}
