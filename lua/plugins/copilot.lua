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
				Stilguide = {
					prompt = [[
            You are an expert Rust developer. 
            When writing code, always:
            - Use idiomatic Rust patterns (ownership, borrowing, lifetimes, Result/Option handling).
            - Prefer enums, traits, and newtypes for domain modeling rather than raw strings or primitive types.
             - Follow Rust naming conventions (snake_case for variables/functions/modules, CamelCase for types/enums).
             - Write ALL variable names, function names, module names, type names, and comments in Norwegian.
             - Structure code cleanly into modules with clear separation of concerns (domain, application, infrastructure).
             - Use `?` operator and proper error handling with custom error types when needed.
             - Avoid unnecessary clones, unwraps, and panics unless absolutely justified.
             - Write concise and readable code with meaningful names.
             - Add doc comments (`///`) for public functions, types, and modules — in Norwegian.
             - When in doubt, follow the Rust API Guidelines and Clippy lint recommendations.
             - Provide tests for critical functions.
           ]],
				},
				PairProg = {
					prompt = [[
             This project follows a “pair-programming” workflow where code and suggestions must prioritize robustness, performance, and security (public sector). The guidelines below apply to all new code and refactoring.
             ## Language (“Norwenglish”)
             - **Technical terms:** English (e.g., *borrow checker*, *trait*, *runtime*, *span*).
             - **Keep conventional naming:** (e.g., "new" not "ny", as_bytes, from_bytes).
             - **Code in `domain`:** Norwegian identifiers (types/functions/variables).
             - **Code in `infrastructure` / `transport`:** Conventional English naming.
             - Avoid unclear abbreviations.
             
            ## Idiomatic Rust
            
            - Follow official Rust guidelines and best practices.
            - Keep `cargo fmt` and `cargo clippy` clean.
            - Use correct borrowing/ownership and standard traits (`From`, `TryFrom`, `AsRef`, `Display`, `Error`, …).
            - No `unwrap()` / `expect()` in production pathways (OK in tests).
            
            ## Architecture & Separation of Concerns
            
            We enforce a strict separation:
            
            - **Domain**
              - No I/O (no HTTP/NATS/DB).
              - Deterministic business rules: types + (pure) functions/methods.
              - Invariants enforced via types and constructors.
              - Error typing with `thiserror` (precise, typed errors).
            
            - **Application**
              - Orchestration/use-cases.
              - “Handler structs” for Dependency Injection (DI).
              - Delegate business rules to the domain (no domain logic in handlers).
              - Stable boundaries via traits (ports).
            
            - **Infrastructure**
              - Isolated adapters for DB/HTTP/NATS, separated from domain.
              - Communication + mapping only (DTO/proto ↔ domain).
              - Clean interfaces, no business rules.
            
            - **Transport**
              - HTTP/NATS entrypoints: request parsing, auth, syntactic input validation.
              - Calls into the application layer.
            
            **Recommended folder structure**
            - `src/domain/…`
            - `src/application/…`
            - `src/infrastructure/{db,http,nats}/…`
            - `src/transport/{http,nats}/…`
            
            ## Code Flow & Readability
            
            - **Happy path left:** guard clauses/early returns, minimal nesting.
            - **Functions over objects:** avoid “doer objects” in `domain` (structs without state that only “do a thing”).
            - Use **internal Context structs** when functions have too many parameters, but do not expose them as public API.
            - Prefer small functions with clear names; split when a function has more than one responsibility.
            
            ## Type Safety & Invariants
            
            - **Make invalid states unrepresentable** (newtypes, enums, private fields).
            - **Parse, don’t validate:** parse into strong types early (e.g., `EpostAdresse` instead of `String`).
            - **Encapsulation:** private fields + public intent-methods (no generic setters).
              - Example: `endre_adresse()` not `set_adresse()`.
            
            ## Error Handling Policy
            
            - **Domain/lib:** `thiserror`, strictly typed errors, classified as:
              - `Transient` (retryable) vs `Permanent` (non-retryable).
            - **Application/edge:** `anyhow` is acceptable in handlers/main for minimal boilerplate.
            - Log *flow* and *outcome* (success/error) and *ids*, never payloads.
            
            ## Resilience & Operations
            
            - **Timeouts:** mandatory on all I/O (DB/HTTP/NATS).
            - **Flow control:** implement backpressure with bounded channels. Never spawn unbounded tasks.
            - **Idempotency:** assume at-least-once delivery. Deduplication is required for message processing.
            - **Graceful shutdown:** support cancellation; make ack/commit semantics explicit.
            
            ## Performance & Compile Times
            
            - Be mindful of monomorphization in infrastructure.
            - Use the **funnel pattern** when it helps: generic wrapper → non-generic internal impl (reduces codegen and binary bloat).
            - **Trait objects heuristic:** prefer `Arc<dyn Trait>` at stable boundaries to reduce compile-time bloat; use generics when they materially improve correctness without exploding compile times.
            
            ## Observability & Safe Logging
            
            - Use `tracing` with spans and correlation IDs across the full flow (transport → application → infrastructure).
            - **Sanitization:** never log PII or secrets. Never log full payloads.
            - Minimum metrics (when applicable): processed/failed, latency, retry-count, dead-letter-count.
            
            ## Security & Supply Chain
            
            - **Secrets:** use `secrecy::Secret` (and zeroize where relevant). Never log secrets.
            - **Dependencies (minimize attack surface):**
              - Prefer the standard library and small, simple in-house implementations when feasible to minimize the vulnerability surface area.
              - Avoid adding crates unless they are clearly necessary for security or correctness.
              - Prefer “few deps, few features”: minimize feature flags, avoid heavy transitive dependency trees.
              - New dependencies must be justified (maintenance, MSRV, license, security posture).
            - **MSRV:** the project has a defined MSRV and it must be respected.
            - **Unsafe:** `#![forbid(unsafe_code)]` by default. Exceptions require documented justification and review.
            - CI should at minimum run: `fmt`, `clippy -D warnings`, `test`, and `cargo audit` (optionally `cargo deny`).
            
            ## Contracts & Compatibility (Protobuf / Subjects)
            
            - Protobuf field numbers must be **reserved** and **never reused**.
            - Backward compatibility is the default.
            - Subject/API versioning must be explicit, with a clear migration strategy.
            
            ## Testing Strategy
            
            - **Domain:** unit tests (deterministic).
            - **Infrastructure:** integration tests (DB/NATS).
            - **Contracts:** contract tests for Protobuf/subjects.
            - Avoid flaky async tests (control time, seed RNG where needed).
            
            ## Definition of Done (short checklist)
            
             - [ ] Domain has no I/O; invariants enforced via types
             - [ ] No PII/secrets in logs; no payload logging
             - [ ] Timeouts/backpressure/idempotency handled where needed
             - [ ] `cargo fmt`, `cargo clippy`, `cargo test` are green
             - [ ] Errors are typed/classified; retry only for transient failures
             - [ ] Observability: spans/correlation IDs on critical flows
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
