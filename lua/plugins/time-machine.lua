return {
	"y3owk1n/time-machine.nvim",
	version = "*", -- remove this if you want to use the `main` branch
	---@type TimeMachine.Config
	opts = {},
	keys = {
		{
			"<leader>tt",
			"<cmd>TimeMachineToggle<cr>",
			desc = "[Time Machine] Toggle Tree",
		},
		{
			"<leader>tl",
			"<cmd>TimeMachineLogShow<cr>",
			desc = "[Time Machine] Show log",
		},
	},
}
