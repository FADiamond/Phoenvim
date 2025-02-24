return {

	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = "mfussenegger/nvim-dap",
		config = function ()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function ()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			vim.keymap.set("n", "<Leader>dc", function()
				dap.continue()
			end, { desc = "[D]ebug Continue" })
			vim.keymap.set("n", "<Leader>do", function()
				dap.step_over()
			end, { desc = "[D]ebug step [O]ver" })
			vim.keymap.set("n", "<Leader>di", function()
				dap.step_into()
			end, { desc = "[D]ebug step [I]nto" })
			vim.keymap.set("n", "<Leader>du", function()
				dap.step_out()
			end, { desc = "[D]ebug step [O]ut" })
			vim.keymap.set("n", "<Leader>dt", function()
				dap.toggle_breakpoint()
			end, { desc = "[D]ebug [T]oggle breakpoint" })

			-- C# configurations
			dap.adapters.coreclr = {
				type = "executable",
				command = "/path/to/dotnet/netcoredbg/netcoredbg",
				args = { "--interpreter=vscode" },
			}
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
			dap.adapters.cppdbg = {
				name = "cppdbg",
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
			}
			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = true,
				},
			}
			dap.configurations.h = dap.configurations.cpp
			dap.configurations.c = dap.configurations.cpp
		end,
	}
}
