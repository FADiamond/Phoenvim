return {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.8",
		branch = 'master',
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- local function get_path_and_tail(filename)
			-- 	local utils = require("telescope.utils")
			-- 	local bufname_tail = utils.path_tail(filename)
			-- 	local path_without_tail = require("plenary.strings").truncate(filename, #filename - #bufname_tail, "")
			-- 	local path_to_display = utils.transform_path({
			-- 		path_display = { "truncate" },
			-- 	}, path_without_tail)
			-- 	return bufname_tail, path_to_display
			-- end
			--
			-- -- Custom entry maker for filename-first display
			-- local function create_filename_first_entry_maker(opts)
			-- 	local make_entry = require("telescope.make_entry")
			-- 	local strings = require("plenary.strings")
			-- 	local utils = require("telescope.utils")
			-- 	local entry_display = require("telescope.pickers.entry_display")
			-- 	local devicons = require("nvim-web-devicons")
			--
			-- 	local def_icon = devicons.get_icon("fname", { default = true })
			-- 	local iconwidth = strings.strdisplaywidth(def_icon)
			--
			-- 	local entry_make = make_entry.gen_from_file(opts)
			--
			-- 	return function(line)
			-- 		local entry = entry_make(line)
			-- 		local displayer = entry_display.create({
			-- 			separator = "",
			-- 			items = {
			-- 				{ width = iconwidth },
			-- 				{ width = nil },
			-- 				{ remaining = true },
			-- 			},
			-- 		})
			--
			-- 		entry.display = function(et)
			-- 			local tail_raw, path_to_display = get_path_and_tail(et.value)
			-- 			local tail = tail_raw .. " "
			-- 			local icon, iconhl = utils.get_devicons(tail_raw)
			--
			-- 			return displayer({
			-- 				{ icon, iconhl },
			-- 				tail,
			-- 				{ path_to_display, "TelescopeResultsComment" },
			-- 			})
			-- 		end
			--
			-- 		-- Heavily prioritize filename in search by repeating it
			-- 		local tail_raw, path_to_display = get_path_and_tail(entry.value)
			-- 		-- Repeat filename multiple times to dominate fuzzy search scoring
			-- 		local filename_priority = tail_raw .. " " .. tail_raw .. " " .. tail_raw .. " " .. tail_raw .. " "
			-- 		entry.ordinal = filename_priority .. entry.value
			--
			-- 		return entry
			-- 	end
			-- end

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			-- vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sf", function()
				require("telescope").extensions.smart_open.smart_open({
					cwd_only = true,
				})
			end, { desc = "[S]earch [F]ile Smart" })
			-- vim.keymap.set("n", "<leader>sF", function()
			-- 	builtin.find_files({ entry_maker = create_filename_first_entry_maker({}) })
			-- end, { desc = "[S]earch [F]iles" })
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

			-- vim.keymap.set("n", "<leader>sF", function()
			-- 	builtin.find_files({
			-- 		prompt_title = "Find All Files (No Ignore)",
			-- 		no_ignore = true,
			-- 		hidden = true,
			-- 		file_ignore_patterns = {}, -- Clear any file ignore patterns
			-- 	})
			-- end, { desc = "[S]earch Every [F]ile" })

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
			-- vim.api.nvim_set_hl(0, "TelescopePathSeparator", { fg = "#6c7086", italic = true })
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
			pcall(telescope.load_extension, "harpoon")
			pcall(telescope.load_extension, "flutter")
			pcall(telescope.load_extension, "remote-sshfs")

			vim.keymap.set("n", "<leader>hm", function()
				telescope.extensions.harpoon.marks()
			end, { desc = "Telescope [H]arpoon [M]arks" })
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
