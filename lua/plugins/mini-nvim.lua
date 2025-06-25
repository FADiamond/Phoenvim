return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup({
			mappings = {
				add = "za", -- Add surrounding in Normal and Visual modes
				delete = "zd", -- Delete surrounding
				find = "zf", -- Find surrounding (to the right)
				find_left = "zF", -- Find surrounding (to the left)
				highlight = "zh", -- Highlight surrounding
				replace = "zr", -- Replace surrounding
				update_n_lines = "zn", -- Update `n_lines`
			},
		})

		require("mini.move").setup()

		require("mini.bufremove").setup()

		require("mini.sessions").setup()

		require("mini.files").setup()

		-- require("mini.git").setup()

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
		vim.keymap.set(
			"n",
			"<leader>bd",
			'<cmd>lua require("mini.bufremove").delete(0, false)<cr>',
			{ desc = "Delete current buffer" }
		)

		vim.keymap.set(
			"n", "<leader>mf",
			"<CMD>lua MiniFiles.open()<CR>",
			{ desc = "[M]ini [F]ile explorer"}
		)
	end,
	mappings = {
		-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
		left = "<M-h>",
		right = "<M-l>",
		down = "<M-j>",
		up = "<M-k>",

		-- Move current line in Normal mode
		line_left = "<M-h>",
		line_right = "<M-l>",
		line_down = "<M-j>",
		line_up = "<M-k>",
	},

	-- Options which control moving behavior
	options = {
		-- Automatically reindent selection during linewise vertical move
		reindent_linewise = true,
	},
}
