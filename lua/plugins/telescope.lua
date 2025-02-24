return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"ThePrimeagen/harpoon",
				-- Normal Harpoon config
				config = function()
					local mark = require("harpoon.mark")
					local ui = require("harpoon.ui")

					-- Example Harpoon keymaps
					vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Harpoon: Add file" })
					vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, { desc = "Harpoon: Toggle menu" })

					-- Jump to specific marks
					vim.keymap.set("n", "<leader>h1", function()
						ui.nav_file(1)
					end, { desc = "Harpoon: Go to mark 1" })
					vim.keymap.set("n", "<leader>h2", function()
						ui.nav_file(2)
					end, { desc = "Harpoon: Go to mark 2" })
					vim.keymap.set("n", "<leader>h3", function()
						ui.nav_file(3)
					end, { desc = "Harpoon: Go to mark 3" })
					vim.keymap.set("n", "<leader>h4", function()
						ui.nav_file(4)
					end, { desc = "Harpoon: Go to mark 4" })
				end,
			},
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

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
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			pcall(telescope.load_extension, "ui-select")
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "harpoon")

			vim.keymap.set("n", "<leader>hm", function()
				telescope.extensions.harpoon.marks()
			end, { desc = "Telescope [H]arpoon [M]arks" })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			-- Keymaps to add file, show menu, etc.
			vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "[H]arpoon [A]dd file" })
			vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, { desc = "[H]arpoo Toggle menu" })

			-- Jump directly to specific marks
			vim.keymap.set("n", "<leader>h1", function()
				ui.nav_file(1)
			end, { desc = "Harpoon: Go to mark 1" })
			vim.keymap.set("n", "<leader>h2", function()
				ui.nav_file(2)
			end, { desc = "Harpoon: Go to mark 2" })
			vim.keymap.set("n", "<leader>h3", function()
				ui.nav_file(3)
			end, { desc = "Harpoon: Go to mark 3" })
			vim.keymap.set("n", "<leader>h4", function()
				ui.nav_file(4)
			end, { desc = "Harpoon: Go to mark 4" })
		end,
	},
}
