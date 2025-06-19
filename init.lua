require("config.options")
require("config.lazy")
require("config.autocmds")
require("config.keymaps")
require("colors")

vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])
