return {
	"mrcjkb/rustaceanvim",
	version = "^4", -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		local mason_registry = require("mason-registry")

		local codelldb = mason_registry.get_package("codelldb")
		local extension_path = codelldb:get_install_path() .. "/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local this_os = vim.uv.os_uname().sysname
		-- The liblldb extension is .so for Linux and .dylib for MacOS
		local liblldb_path = extension_path .. "lldb/lib/liblldb" .. (this_os == "Linux" and ".so" or ".dylib")

		local cfg = require("rustaceanvim.config")
		vim.g.rustaceanvim = {
			dap = {
				adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		}
	end,
}
