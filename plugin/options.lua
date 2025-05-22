local opt = vim.opt

-- Numbers
opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.smartindent = true

opt.clipboard = "unnamedplus"

opt.laststatus = 3

-- Don't have `o` add a comment
opt.formatoptions:remove("o")

opt.wrap = false
-- Use ripgrep if available
--if fn.executable("rg") == 1 then
--	opt.grepprg = "rg --vimgrep --no-heading --smart-case"
--end

opt.termguicolors = false

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- vim.diagnostic.config({
-- 	virtual_text = true,
-- 	virtual_lines = { current_line = true },
-- 	float = {
-- 		border = "rounded",
-- 	},
-- 	underline = true,
-- 	update_in_insert = false,
-- })

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
	end,
})
