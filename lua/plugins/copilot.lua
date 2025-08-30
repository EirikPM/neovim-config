return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken", -- Kun for Linux og Mac
		opts = {
			model = "gpt-5",
			temperature = 0.1,

			headers = {
				user = "👤 You: ",
				assistant = "🤖 Copilot: ",
				tool = "🔧 Tool: ",
			},

			prompts = {
				Rename = {
					prompt = "Du får en markert kodeblokk som input. Oppgaven din er KUN å rename variabler, funksjoner og felt til norske, beskrivende navn.",
					selection = function(source)
						local select = require("CopilotChat.select")
						return select.visual(source)
					end,
				},
				Forbedre = {
					prompt = "Optimaliser den markerte koden for bedre ytelse og lesbarhet uten å endre atferd. Foreslå også hvordan koden kan deles opp i moduler/filer der det er hensiktsmessig. Returner først oppdatert kode, deretter en kort forklaring på endringene og et forslag til filstruktur.",
					selection = function(source)
						local select = require("CopilotChat.select")
						return select.visual(source)
					end,
				},
				Tracelogging = {
					prompt = [[
          Gjør koden idiomatisk med tracing:
          - Legg til #[instrument] på offentlige async-funksjoner, bruk skip(...) på store/hemmelige parametere.
          - Bytt til anyhow::Result i ikke-domene-kode og legg på .context(...) der IO/nett kan feile.
          - Vis eksempel på RUST_LOG-verdier.
          ]],
				},
				DelOppModul = {
					prompt = [[
          Analyser gjeldende buffer og vurder modul-splitting:
          - Pek ut tydelige ansvar/ideer og foreslå modulgrenser (domene/applikasjon/infrastruktur).
          - Foreslå fil-/mappenavn på norsk.
          - Vis unified diff for: mod-oppdateringer, nye filer med skjelett, og re-eksport i mod.rs.
          - Marker hvilke symboler som bør være pub vs pub(crate).
          - Legg til #[instrument] der det gir mening, og bruk anyhow i adaptere.
          ]],
				},
			},
		},
		keys = {
			{ "<leader>ct", ":CopilotChatToggle<CR>", desc = "CopilotChat - Toggle" },
			{ "<leader>cS", ":CopilotChatStop<CR>", desc = "CopilotChat - Stop Generating" },

			{ "<leader>cr", ":CopilotChatRename<CR>", mode = "v", desc = "CopilotChat - Rename" },
			{ "<leader>cR", ":CopilotChatReview<CR>", mode = "v", desc = "CopilotChat - Review code" },
			{ "<leader>co", ":CopilotChatOptimize<CR>", mode = "v", desc = "CopilotChat - Optimize code" },
			{ "<leader>ct", ":CopilotChatTests<CR>", mode = "v", desc = "CopilotChat - Write tests" },
			{ "<leader>cd", ":CopilotChatDocs<CR>", mode = "v", desc = "CopilotChat - Write documentation" },
			{ "<leader>cf", ":CopilotChatForbedre<CR>", mode = "v", desc = "CopilotChat - Forbedre code" },

			{ "<leader>cp", ":CopilotChatPrompts<CR>", desc = "CopilotChat - View/Select Prompts" },
			{ "<leader>cm", ":CopilotChatModels<CR>", desc = "CopilotChat - View/Select Models" },
		},
	},
}
