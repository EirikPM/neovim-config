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

-- Don't have `o` add a comment
opt.formatoptions:remove("o")

opt.wrap = false
-- Use ripgrep if available
--if fn.executable("rg") == 1 then
--	opt.grepprg = "rg --vimgrep --no-heading --smart-case"
--end

opt.termguicolors = false
