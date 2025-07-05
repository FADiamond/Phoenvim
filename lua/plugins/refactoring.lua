return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	opts = {},
	config = function(_, opts)
		require("refactoring").setup({
			prompt_func_return_type = {
				go = true,
				java = true,
				cpp = true,
				c = true,
				h = true,
				hpp = true,
				cxx = true,
			},
			prompt_func_param_type = {
				go = true,
				java = true,
				cpp = true,
				c = true,
				h = true,
				hpp = true,
				cxx = true,
			},
		})
		vim.keymap.set({ "n", "x" }, "<leader>rr", function()
			require("refactoring").select_refactor()
		end)
	end,
}
