return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = false, -- Important! Set to false to ensure it loads right away
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			-- Get the absolute path to your vault
			local vault_path = "/home/fadiamond/Main vault"

			require("obsidian").setup({
				workspaces = {
					{
						name = "personal",
						path = vault_path,
					},
				},

				-- Where to put new notes
				-- notes_subdir = "notes",

				-- Log level (set to WARN for fewer messages)
				log_level = vim.log.levels.INFO,

				-- Important! Enable completion
				completion = {
					nvim_cmp = true, -- Enable nvim-cmp source
					min_chars = 0, -- Trigger completion at 2 chars
				},

				-- Default keymappings
				mappings = {
					["gf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					["<leader>ch"] = {
						action = function()
							return require("obsidian").util.toggle_checkbox()
						end,
						opts = { buffer = true },
					},
					["<cr>"] = {
						action = function()
							return require("obsidian").util.smart_action()
						end,
						opts = { buffer = true, expr = true },
					},
				},

				-- Where to put new notes
				new_notes_location = "current_dir",

				-- Define note ID format
				note_id_func = function(title)
					local suffix = ""
					if title ~= nil then
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return tostring(os.time()) .. "-" .. suffix
				end,

				-- Use ID prefixes for wiki links
				wiki_link_func = function(opts)
					return require("obsidian.util").wiki_link_id_prefix(opts)
				end,

				-- Set markdown style links
				markdown_link_func = function(opts)
					return require("obsidian.util").markdown_link(opts)
				end,

				-- Set link style
				preferred_link_style = "wiki",

				-- Don't disable frontmatter
				disable_frontmatter = false,

				-- Custom frontmatter formatting
				note_frontmatter_func = function(note)
					if note.title then
						note:add_alias(note.title)
					end

					local out = { id = note.id, aliases = note.aliases, tags = note.tags }

					if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
						for k, v in pairs(note.metadata) do
							out[k] = v
						end
					end

					return out
				end,

				-- Handle external URLs
				follow_url_func = function(url)
					-- Open the URL in the default web browser on Windows
					vim.fn.jobstart({ "cmd.exe", "/c", "start", url })
				end,

				-- Don't use advanced URI
				use_advanced_uri = false,

				-- Don't force foreground app
				open_app_foreground = false,

				-- Use Telescope for picking
				picker = {
					name = "telescope.nvim",
					mappings = {
						new = "<C-x>",
						insert_link = "<C-l>",
					},
				},

				-- Sort by last modified
				sort_by = "modified",
				sort_reversed = true,

				-- Set reasonable search limits
				search_max_lines = 1000,

				-- Open notes in current window by default
				open_notes_in = "current",

				-- UI settings (checkboxes, bullets, etc.)
				ui = {
					enable = false, -- set to false to disable all additional syntax features
					update_debounce = 200, -- update delay after a text change (in milliseconds)
					max_file_length = 5000, -- disable UI features for files with more than this many lines
					-- Define how various check-boxes are displayed
					checkboxes = {
						-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
						[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
						["x"] = { char = "", hl_group = "ObsidianDone" },
						[">"] = { char = "", hl_group = "ObsidianRightArrow" },
						["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
						["!"] = { char = "", hl_group = "ObsidianImportant" },
						-- Replace the above with this if you don't have a patched font:
						-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
						-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

						-- You can also add more custom ones...
					},
					-- Use bullet marks for non-checkbox lists.
					bullets = { char = "•", hl_group = "ObsidianBullet" },
					external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
					-- Replace the above with this if you don't have a patched font:
					-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
					reference_text = { hl_group = "ObsidianRefText" },
					highlight_text = { hl_group = "ObsidianHighlightText" },
					tags = { hl_group = "ObsidianTag" },
					block_ids = { hl_group = "ObsidianBlockID" },
					hl_groups = {
						-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
						ObsidianTodo = { bold = true, fg = "#f78c6c" },
						ObsidianDone = { bold = true, fg = "#89ddff" },
						ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
						ObsidianTilde = { bold = true, fg = "#ff5370" },
						ObsidianImportant = { bold = true, fg = "#d73128" },
						ObsidianBullet = { bold = true, fg = "#89ddff" },
						ObsidianRefText = { underline = true, fg = "#c792ea" },
						ObsidianExtLinkIcon = { fg = "#c792ea" },
						ObsidianTag = { italic = true, fg = "#89ddff" },
						ObsidianBlockID = { italic = true, fg = "#89ddff" },
						ObsidianHighlightText = { bg = "#75662e" },
					},
				},

				-- Image attachment settings
				attachments = {
					img_folder = "assets/imgs",
					img_text_func = function(client, path)
						path = client:vault_relative_path(path) or path
						return string.format("![%s](%s)", path.name, path)
					end,
				},
			})

			-- Add custom keymappings
			vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New note" })
			vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert template" })
			vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Find note" })
			vim.keymap.set("n", "<leader>og", "<cmd>ObsidianSearch<CR>", { desc = "Search in notes" })
			vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show backlinks" })
			vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show links in current buffer" })
		end,
	},
	{
		"preservim/vim-markdown",
		ft = { "markdown" },
		config = function()
			-- Don't hide markdown syntax
			-- vim.g.vim_markdown_conceal = 0
			-- vim.g.vim_markdown_conceal_code_blocks = 0
			--
			-- -- Enable TOC window auto-fit
			-- vim.g.vim_markdown_toc_autofit = 1
			--
			-- -- Follow markdown links with ge
			-- vim.g.vim_markdown_follow_anchor = 1
			--
			-- -- Highlight YAML front matter
			-- vim.g.vim_markdown_frontmatter = 1
			--
			-- Strikethrough uses two tildes
			vim.g.vim_markdown_strikethrough = 1

			-- Don't automatically insert bulletpoints
			vim.g.vim_markdown_auto_insert_bullets = 1
			vim.g.vim_markdown_new_list_item_indent = 1

			vim.g.vim_markdown_new_list_item_indent = 1

			vim.g.vim_markdown_folding_disabled = 1

			vim.g.vim_markdown_no_default_key_mappings = 1
		end,
	},
}
