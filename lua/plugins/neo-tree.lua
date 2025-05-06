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
				window = {
					mappings = {
						["R"] = "easy",
					},
				},
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_by_name = {
						".git",
						".DS_Store",
						"thumbs.db",
					},
				},
				commands = {
					["easy"] = function(state)
						local node = state.tree:get_node()
						local path = node.type == "directory" and node.path or vim.fs.dirname(node.path)
						require("easy-dotnet").create_new_item(path, function()
							require("neo-tree.sources.manager").refresh(state.name)
						end)
					end,
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
