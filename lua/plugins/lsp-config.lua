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
				"volar",
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
			local volar_path = mason_path .. "/vue-language-server/node_modules/@vue/language-server"
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

			-- lspconfig.dartls.setup({
			-- 	capabilities = capabilities,
			-- })
			--
			-- lspconfig.dcmls.setup({
			-- 	capabilities = capabilities,
			-- 	cmd = {
			-- 		"dcm",
			-- 		"start-server",
			-- 	},
			-- 	filetypes = { "dart", "yaml" },
			-- 	settings = {
			-- 		dart = {
			-- 			analysisExcludedFolders = {
			-- 				vim.fn.expand("$Home/.pub-cache"),
			-- 			},
			-- 		},
			-- 	},
			-- })

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
							location = volar_path,
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

			-- Volar for Vue files
			lspconfig.volar.setup({
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

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
			vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "[G]o to [D]eclaration" })
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition" })
			vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "[G]o to [T]ype Definition" })
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences" })
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "[G]o to [I]mplementations" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			vim.keymap.set({ "n", "v" }, "<leader>cr", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
			vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "[C]ode [S]ignature help" })
			vim.keymap.set("n", "<leader>cic", vim.lsp.buf.incoming_calls, { desc = "[C]ode [I]ncoming [C]alls" })
			vim.keymap.set("n", "<leader>coc", vim.lsp.buf.outgoing_calls, { desc = "[C]ode [O]utgoing [C]alls" })

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
				virtual_text = false,
				-- virtual_text = { current_line = true },  only added in neovim v11.1
				update_in_insert = true,
				float = {
					source = true,
					border = "rounded",
				},
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				-- Use a sharp border with `FloatBorder` highlights
				border = "rounded"
			})


			vim.g.diagnostics_virtual_text_enabled = false
			vim.keymap.set("n", "<leader>tv", function()
				vim.g.diagnostics_virtual_text_enabled = not vim.g.diagnostics_virtual_text_enabled
				vim.diagnostic.config({ virtual_text = vim.g.diagnostics_virtual_text_enabled })
			end, { desc = "[T]oggle diagnostics [V]irtual text" })

			-- Go to next/previous diagnostic
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

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
