return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_fond },
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_by_name = {
						".git",
						".DS_Store",
						"thumbs.db",
					},
				},
			},
		})
		vim.keymap.set(
			"n",
			"<leader>e",
			":Neotree toggle filesystem reveal left<CR>",
			{ desc = "Toggle file [E]xplorer" }
		)
	end,
}
