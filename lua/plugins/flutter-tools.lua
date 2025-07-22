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
					-- capabilities = capabilities,
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
						dart = {
							experimentalRefactors = true,
							previewLsp = true,
						},
					},
				},
				decorations = {
					statusline = {
						device = true,
						project_config = true,
					},
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

			vim.keymap.set("n", "<leader>Ffd", ":FlutterRun<CR>", { desc = "[F]lutter [R]un [D]ebug mode" })
			vim.keymap.set("n", "<leader>Ffr", ":FlutterRun --release<CR>", { desc = "[F]lutter [R]un [R]elease mode" })
			vim.keymap.set("n", "<leader>Ffp", ":FlutterRun --profile<CR>", { desc = "[F]lutter [R]un [P]rofile mode" })
			vim.keymap.set("n", "<leader>Fq", ":FlutterQuit<CR>", { desc = "[F]lutter [Q]uit" })
			vim.keymap.set("n", "<leader>Fr", ":FlutterReload<CR>", { desc = "[F]lutter [R]eload" })
			vim.keymap.set("n", "<leader>FR", ":FlutterRestart<CR>", { desc = "[F]lutter [R]estart" })
			vim.keymap.set("n", "<leader>Fo", ":FlutterOutlineToggle<CR>", { desc = "[F]lutter [O]utline toggle" })
			vim.keymap.set("n", "<leader>Fl", ":FlutterLogToggle<CR>", { desc = "[F]lutter [L]og toggle" })
			vim.keymap.set("n", "<leader>Fd", ":FlutterDevices<CR>", { desc = "[F]lutter [D]evices" })
			vim.keymap.set("n", "<leader>Fg", function()
				local output = {}

				require("snacks").notify("Running build_runner build...", { type = "info" })

				vim.fn.jobstart("dart run build_runner build", {
					on_stdout = function(_, data)
						if data then
							vim.list_extend(output, data)
						end
					end,
					on_stderr = function(_, data)
						if data then
							vim.list_extend(output, data)
						end
					end,
					on_exit = function(_, exit_code)
						local result = table.concat(output, "\n")

						if exit_code == 0 then
							require("snacks").notify("Build completed!\n" .. result, {
								type = "success",
								timeout = 5000,
							})
						else
							require("snacks").notify("Build failed!\n" .. result, {
								type = "error",
								timeout = 10000,
							})
						end
					end,
				})
			end, { desc = "[F]lutter [G]enerate" })
		end,
	},
	{
		"dart-lang/dart-vim-plugin",
	},
}
