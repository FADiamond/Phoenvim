return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dap")

		vim.keymap.set("n", "<Leader>dc", function()
			dap.continue()
		end)
		vim.keymap.set("n", "<Leader>do", function()
			dap.step_over()
		end)
		vim.keymap.set("n", "<Leader>di", function()
			dap.step_into()
		end)
		vim.keymap.set("n", "<Leader>du", function()
			dap.step_out()
		end)
		vim.keymap.set("n", "<Leader>dt", function()
			dap.toggle_breakpoint()
		end)
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
		-- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
		--     require('dap.ui.widgets').hover()
		-- end)
		-- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
		--     require('dap.ui.widgets').preview()
		-- end)
		-- vim.keymap.set('n', '<Leader>df', function()
		--     local widgets = require('dap.ui.widgets')
		--     widgets.centered_float(widgets.frames)
		-- end)
		-- vim.keymap.set('n', '<Leader>ds', function()
		--     local widgets = require('dap.ui.widgets')
		--     widgets.centered_float(widgets.scopes)
		-- end)

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
	end,
}
