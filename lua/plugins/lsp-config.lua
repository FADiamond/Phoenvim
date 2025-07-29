return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				registries = {
					"github:Crashdummyy/mason-registry",
					"github:mason-org/mason-registry",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				-- "basedpyright",
				-- "pylsp",
				-- "tinymist",
				"vue_ls",
				"html",
				"cssls",
				"eslint",
				"gradle_ls",
				"jdtls",
				"omnisharp",
			},
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = { lsp = { auto_attach = true } },
			},
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
			local vue_ls = mason_path .. "/vue-language-server/node_modules/@vue/language-server"
			-- 	local mason_registry = require("mason-registry")
			-- 	local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
			-- .. "/node_modules/@vue/language-server"

			vim.keymap.set("n", "<leader>tn", function()
				require("nvim-navbuddy").open()
			end, { desc = "[T]oggle [N]avbuddy" })

			require("mason-tool-installer").setup({
				-- Install these linters, formatters, debuggers automatically
				ensure_installed = {
					"java-debug-adapter",
					"java-test",
				},
			})
			vim.api.nvim_command("MasonToolsInstall")
			local jdtls = function()
				require("java").setup({
					-- Your custom nvim-java configuration goes here
				})
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
			})
			lspconfig.basedpyright.setup({
				capabilities = capabilities,
			})

			-- Webdev LSP Servers
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_ls,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			})

			-- vue_ls for Vue files
			vim.lsp.enable("vue_ls")
			vim.lsp.config("vue_ls", {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "vue" },
				-- Only activate in Vue projects
				root_dir = lspconfig.util.root_pattern(
					"package.json",
					"vue.config.js",
					"vue.config.ts",
					"nuxt.config.js",
					"nuxt.config.ts"
				),
				init_options = {
					typescript = {
						tsdk = mason_path .. "/typescript-language-server/node_modules/typescript/lib",
					},
					languageFeatures = {
						implementation = true,
						references = true,
						definition = true,
						typeDefinition = true,
						callHierarchy = true,
						hover = true,
						rename = true,
						renameFileRefactoring = true,
						signatureHelp = true,
						codeAction = true,
						workspaceSymbol = true,
						diagnostics = true,
					},
				},
			})
			-- HTML
			lspconfig.html.setup({
				capabilities = capabilities,
			})

			-- CSS
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			-- ESLint
			-- lspconfig.eslint.setup({
			-- 	capabilities = capabilities,
			-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
			-- 	settings = {
			-- 		codeAction = {
			-- 			disableRuleComment = {
			-- 				enable = true,
			-- 				location = "separateLine",
			-- 			},
			-- 			showDocumentation = { enable = true },
			-- 		},
			-- 		format = true,
			-- 		nodePath = "",
			-- 		onIgnoredFiles = "off",
			-- 		workingDirectory = { mode = "location" },
			-- 	},
			-- })
			--
			-- lspconfig.ruff.setup({
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		ruff = {
			-- 			lint = {
			-- 				enable = true,
			-- 			},
			-- 			organizeImports = true,
			-- 			fixAll = true,
			-- 		},
			-- 	},
			-- 	on_attach = function(client, bufnr)
			-- 		require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
			-- 		local function format_and_organize()
			-- 			vim.lsp.buf.format({ async = false, timeout_ms = 100 })
			-- 		end
			-- 		vim.keymap.set("n", "<leader>cF", format_and_organize, {
			-- 			buffer = bufnr,
			-- 			desc = "Format ruff",
			-- 		})
			-- 	end,
			-- })

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.tinymist.setup({
				capabilities = capabilities,
			})

			lspconfig.omnisharp.setup({
				capabilities = capabilities,
			})

			local function goto_definition_split()
				vim.cmd("split")
				vim.lsp.buf.definition()
			end

			local function goto_definition_vsplit()
				vim.cmd("vsplit")
				vim.lsp.buf.definition()
			end

			local function goto_declaration_split()
				vim.cmd("split")
				vim.lsp.buf.declaration()
			end

			local function goto_declaration_vsplit()
				vim.cmd("vsplit")
				vim.lsp.buf.declaration()
			end

			local function goto_type_definition_split()
				vim.cmd("split")
				vim.lsp.buf.type_definition()
			end

			local function goto_type_definition_vsplit()
				vim.cmd("vsplit")
				vim.lsp.buf.type_definition()
			end

			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover({ border = "rounded", max_height = 26 })
			end, { desc = "Hover" })

			-- Regular (current buffer)
			vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "[G]o to [D]eclaration" })
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition" })
			vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "[G]o to [T]ype Definition" })

			-- Horizontal splits
			vim.keymap.set("n", "<leader>ghD", goto_declaration_split, { desc = "[G]o to [D]eclaration in [S]plit" })
			vim.keymap.set("n", "<leader>ghd", goto_definition_split, { desc = "[G]o to [D]efinition in [S]plit" })
			vim.keymap.set(
				"n",
				"<leader>ght",
				goto_type_definition_split,
				{ desc = "[G]o to [T]ype Definition in [S]plit" }
			)

			-- Vertical splits
			vim.keymap.set("n", "<leader>gvD", goto_declaration_vsplit, { desc = "[G]o to [D]eclaration in [V]split" })
			vim.keymap.set("n", "<leader>gvd", goto_definition_vsplit, { desc = "[G]o to [D]efinition in [V]split" })
			vim.keymap.set(
				"n",
				"<leader>gvt",
				goto_type_definition_vsplit,
				{ desc = "[G]o to [T]ype Definition in [V]split" }
			)

			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences" })
			vim.keymap.set("n", "<leader>gI", vim.lsp.buf.implementation, { desc = "[G]o to [I]mplementations" })
			vim.keymap.set("n", "<leader>gic", vim.lsp.buf.incoming_calls, { desc = "[G]o to [I]ncoming [C]alls" })
			vim.keymap.set("n", "<leader>goc", vim.lsp.buf.outgoing_calls, { desc = "[G]o to [O]utgoing [C]alls" })

			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			vim.keymap.set({ "n", "v" }, "<leader>cr", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
			vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "[C]ode [S]ignature help" })

			local border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "┐", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "┘", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "└", "FloatBorder" },
				{ "│", "FloatBorder" },
			}

			vim.diagnostic.config({
				underline = true,
				sings = true,
				-- virtual_text = false,
				virtual_text = { current_line = false },
				update_in_insert = true,
				jump = {
					float = true, -- TO match goto_next/previous diagnostic
				},
				float = {
					source = true,
					border = "rounded",
				},
			})

			vim.g.diagnostics_virtual_text_enabled = false
			vim.keymap.set("n", "<leader>tv", function()
				vim.g.diagnostics_virtual_text_enabled = not vim.g.diagnostics_virtual_text_enabled
				vim.diagnostic.config({ virtual_text = vim.g.diagnostics_virtual_text_enabled })
			end, { desc = "[T]oggle diagnostics [V]irtual text" })

			-- Show a floating diagnostics window
			vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "[C]ode [D]iagnostics" })

			-- Error: red squiggly line
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
				undercurl = true, -- squiggly style
				sp = "#db4b4b", -- color for the curl
			})

			-- Warning: yellow/orange squiggly line
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
				undercurl = true,
				sp = "#e0af68",
			})

			-- Info: (optional) blue-ish
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
				undercurl = true,
				sp = "#0db9d7",
			})

			-- Hint: (optional) green-ish
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
				undercurl = true,
				sp = "#1abc9c",
			})

			-- 			-- A table of your preferred icons (Nerd Fonts or any unicode characters)
			-- 			local signs = {
			-- 				Error = "", -- e.g. nf-mdi-close_circle or nf-fa-times_circle
			-- 				Warn = "", -- e.g. nf-fa-exclamation_triangle
			-- 				Hint = "", -- e.g. nf-fa-lightbulb_o
			-- 				Info = "", -- e.g. nf-fa-info_circle
			-- }
			--
			-- 			for type, icon in pairs(signs) do
			-- 				local hl = "DiagnosticSign" .. type
			-- 				vim.fn.sign_define(hl, {
			-- 					text = icon,
			-- 					texthl = hl, -- Use the same highlight group as the name
			-- 					numhl = "", -- If you prefer a highlight for line numbers, define it here
			-- 				})
			-- 			end
		end,
	},
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "InsertEnter",
	-- 	opts = {
	-- 		bind = true,
	-- 		handler_opts = {
	-- 			border = "rounded",
	-- 		},
	-- 	},
	-- 	-- or use config
	-- 	-- config = function(_, opts) require'lsp_signature'.setup({you options}) end
	-- },
}
