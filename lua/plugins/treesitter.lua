return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- Installerer bare parserne som mangler.
			require("nvim-treesitter").install({
				"rust",
				"toml",
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"html",
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterFeatures", { clear = true }),
				callback = function(event)
					local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)

					if not lang or not vim.treesitter.language.add(lang) then return end

					vim.treesitter.start(event.buf, lang)

					if vim.treesitter.query.get(lang, "indents") then
						vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {},
		enabled = false,
	},
	{
		{
			"windwp/nvim-ts-autotag",
			opts = {},
		},
	},
}
