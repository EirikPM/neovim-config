return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				opts = {},
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		config = function()
			local set = vim.keymap.set
			local dap = require("dap")
			local dapui = require("dapui")

			-- Keymaps
			set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			set("n", "<leader>dc", dap.continue, { desc = "Launch Debugging" })

			-- UI
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
