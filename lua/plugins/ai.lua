return {
	"folke/sidekick.nvim",
	opts = {
		nes = { enabled = false },
	},
	keys = {
		{
			"<leader>oo",
			function()
				require("sidekick.cli").toggle({
					name = "opencode",
					focus = true,
				})
			end,
			desc = "OpenCode",
		},
		{
			"<leader>ov",
			function()
				require("sidekick.cli").send({
					name = "opencode",
					msg = "{selection}",
					focus = true,
					submit = false,
				})
			end,
			mode = "x",
			desc = "OpenCode: legg til markert kode",
		},
	},
}
