return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Set up DAP UI
			dapui.setup()

			-- Auto-open and close dapui
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

			-- Debug keymaps
			vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "[D]ebug [C]ontinue" })
			vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "[D]ebug step [O]ver" })
			vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "[D]ebug step [I]nto" })
			vim.keymap.set("n", "<Leader>du", dap.step_out, { desc = "[D]ebug step O[u]t" })
			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle breakpoint" })
			vim.keymap.set("n", "<Leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "[D]ebug Set [B]reakpoint with condition" })

			dap.configurations.java = {
				{
					name = "Debug Launch (2GB)",
					type = "java",
					request = "launch",
					vmArgs = "" .. "-Xmx2g ",
				},
				{
					name = "Debug Attach (8000)",
					type = "java",
					request = "attach",
					hostName = "127.0.0.1",
					port = 8000,
				},
				{
					name = "Debug Attach (5005)",
					type = "java",
					request = "attach",
					hostName = "127.0.0.1",
					port = 5005,
				},
				{
					name = "My Custom Java Run Configuration",
					type = "java",
					request = "launch",
					-- You need to extend the classPath to list your dependencies.
					-- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
					-- classPaths = {},

					-- If using multi-module projects, remove otherwise.
					-- projectName = "yourProjectName",

					-- javaExec = "java",
					mainClass = "replace.with.your.fully.qualified.MainClass",

					-- If using the JDK9+ module system, this needs to be extended
					-- `nvim-jdtls` would automatically populate this property
					-- modulePaths = {},
					vmArgs = "" .. "-Xmx2g ",
				},
			}

			-- C# adapter configuration
			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.exepath("netcoredbg"),
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
			-- C/C++ adapter configuration
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			-- Python adapter configuration
			dap.adapters.python = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = function()
						-- Try to detect python path from active virtual environment
						if vim.env.VIRTUAL_ENV then
							return vim.env.VIRTUAL_ENV .. "/bin/python"
						end
						-- Or use the system wide python
						return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
					end,
				},
				{
					type = "python",
					request = "launch",
					name = "Launch with arguments",
					program = "${file}",
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.fn.split(args_string, " ")
					end,
					pythonPath = function()
						-- Try to detect python path from active virtual environment
						if vim.env.VIRTUAL_ENV then
							return vim.env.VIRTUAL_ENV .. "/bin/python"
						end
						-- Or use the system wide python
						return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
					end,
				},
			}
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = { "codelldb" },
			automatic_installation = true,
			handlers = {
				function(config)
					-- default handler
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		},
	},
	{
		-- Inline Debug Text
		-- https://github.com/theHamsta/nvim-dap-virtual-text
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		opts = {
			-- Display debug text as a comment
			commented = true,
			-- Customize virtual text
			display_callback = function(variable, buf, stackframe, node, options)
				if options.virt_text_pos == "inline" then
					return " = " .. variable.value
				else
					return variable.name .. " = " .. variable.value
				end
			end,
		},
	},
}
