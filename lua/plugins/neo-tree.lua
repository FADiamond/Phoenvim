return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_fond },
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		---@module "neo-tree"
		---@type neotree.Config?
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
				default_component_configs = {
					icon = {
						provider = function(icon, node) -- setup a custom icon provider
							local text, hl
							local mini_icons = require("mini.icons")
							if node.type == "file" then -- if it's a file, set the text/hl
								text, hl = mini_icons.get("file", node.name)
							elseif node.type == "directory" then -- get directory icons
								text, hl = mini_icons.get("directory", node.name)
								-- only set the icon text if it is not expanded
								if node:is_expanded() then
									text = nil
								end
							end

							-- set the icon text/highlight only if it exists
							if text then
								icon.text = text
							end
							if hl then
								icon.highlight = hl
							end
						end,
					},
					kind_icon = {
						provider = function(icon, node)
							local mini_icons = require("mini.icons")
							icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
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
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
			-- TODO : potentially setup the lspconfig parameters (see the doc)
			require("lsp-file-operations").setup()
		end,
	},
}
