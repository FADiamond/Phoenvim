return {
	{
		"akinsho/flutter-tools.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("flutter-tools").setup({
				flutter_path = nil,
				fvm = false,
				widget_guides = { enabled = true },
				closing_tags = {
					highlight = "Comment",
					prefix = "//",
					enabled = true,
				},
				lsp = {
					capabilities = capabilities,
					color = { -- show the derived colours for dart variables
						enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
						background = false, -- highlight the background
						background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
						foreground = false, -- highlight the foreground
						virtual_text = true, -- show the highlight using virtual text
						virtual_text_str = "■", -- the virtual text character to highlight
					},
					settings = {
						showtodos = true,
						completefunctioncalls = true,
						analysisexcludedfolders = {
							vim.fn.expand("$Home/.pub-cache"),
						},
						renamefileswithclasses = "prompt",
						updateimportsonrename = true,
						enablesnippets = true,
					},
				},
				decorations = {
					statusline = {
						device = true,
						project_config = true,
					}
				},
				debugger = {
					enabled = false,
					run_via_dap = false,
					exception_breakpoints = {},
					register_configurations = function(paths)
						local dap = require("dap")
						-- See also: https://github.com/akinsho/flutter-tools.nvim/pull/292
						dap.configurations.dart = {
							{
								type = "dart",
								request = "launch",
								name = "Launch dart",
								dartSdkPath = "~/development/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
								flutterSdkPath = "~/development/flutter/bin/flutter", -- ensure this is correct
								program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
								cwd = "${workspaceFolder}",
							},
							{
								type = "flutter",
								request = "launch",
								name = "Launch flutter",
								dartSdkPath = "~/development/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
								flutterSdkPath = "~/development/flutter/bin/flutter", -- ensure this is correct
								program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
								cwd = "${workspaceFolder}",
							},
						}

						-- Dart CLI adapter (recommended)
						dap.adapters.dart = {
							type = "executable",
							command = "dart", -- if you're using fvm, you'll need to provide the full path to dart (dart.exe for windows users), or you could prepend the fvm command
							args = { "debug_adapter" },
							-- windows users will need to set 'detached' to false
							options = {
								detached = false,
							},
						}
						dap.adapters.flutter = {
							type = "executable",
							command = "flutter", -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
							args = { "debug_adapter" },
							-- windows users will need to set 'detached' to false
							options = {
								detached = false,
							},
						}
						require("dap.ext.vscode").load_launchjs()
					end,
				},
			})

			vim.keymap.set("n", "<leader>ff", ":FlutterRun<CR>", { desc = "[F]lutter [R]un" })
			vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>", { desc = "[F]lutter [Q]uit" })
			vim.keymap.set("n", "<leader>fr", ":FlutterReload<CR>", { desc = "[F]lutter [R]eload" })
			vim.keymap.set("n", "<leader>fR", ":FlutterRestart<CR>", { desc = "[F]lutter [R]estart" })
			vim.keymap.set("n", "<leader>fo", ":FlutterOutlineToggle<CR>", { desc = "[F]lutter [O]utline toggle" })
			vim.keymap.set("n", "<leader>fl", ":FlutterLogToggle<CR>", { desc = "[F]lutter [L]og toggle" })
		end,
	},
	{
		"dart-lang/dart-vim-plugin",
	},
}
