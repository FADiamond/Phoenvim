return {
	{
		"nvim-telescope/telescope.nvim",
		branch = 'master',
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					path_display = { "filename_first" }
				}
			})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", function()
				require("telescope").extensions.smart_open.smart_open({
					cwd_only = true,
				})
			end, { desc = "[S]earch [F]ile Smart" })
			vim.keymap.set("n", "<leader>sF", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>st", builtin.builtin, { desc = "[S]earch Select [T]elescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sG", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", function()
				builtin.buffers({
					entry_maker = require("rc.telescope.my_make_entry").gen_from_buffer_like_leaderf(),
				})
			end, { desc = "[ ] Find existing buffers" })
			local fuzzy_search = function()
				builtin.grep_string({ shorten_path = true, word_match = "-w", only_sort_text = true, search = "" })
			end
			vim.keymap.set("n", "<leader>sg", fuzzy_search, { desc = "[S]earch Fuzzily [G]rep" })

			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local telescope = require("telescope")
			-- vim.api.nvim_set_hl(0, "TelescopePreviewLine", { bg = "35363b" })
			-- vim.api.nvim_set_hl(0, "TelescopePreviewDirectory", {
			-- 	fg = "#ffffff",
			-- 	bold = true,
			-- })
			
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					smart_open = {
						result_limit = 100, -- Default is 40
					},
				},
			})
			pcall(telescope.load_extension, "ui-select")
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "flutter")
			pcall(telescope.load_extension, "remote-sshfs")
		end,
	},
	{
		"benfowler/telescope-luasnip.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("telescope").load_extension("luasnip")

			-- Add a keybinding to browse snippets
			vim.keymap.set("n", "<leader>sS", "<cmd>Telescope luasnip<CR>", {
				desc = "[S]earch [S]nippets",
			})
		end,
	},
	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		config = function()
			require("telescope").load_extension("smart_open")
		end,
		dependencies = {
			-- NOTE: sqlite3 must be installed
			"kkharji/sqlite.lua",
			-- Only required if using match_algorithm fzf
			-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
			-- { "nvim-telescope/telescope-fzy-native.nvim" },
		},
	},
}
