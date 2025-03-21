return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged_enable = true,
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		auto_attach = true,
		attach_to_untracked = false,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
			use_focus = true,
		},
		current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
		preview_config = {
			-- Options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},

		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end)

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end)

			-- Actions
			map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[S]tage [H]unk" })
			map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[R]eset [H]unk" })

			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "[S]tage [H]unk" })

			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "[R]eset [H]unk" })

			map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
			map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[R]eset buffer" })
			map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[P]review Hunk" })
			map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview [H]unk [I]nline" })

			map("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "[B]lame line" })

			map("n", "<leader>hd", gitsigns.diffthis, { desc = "[D]iff this" })

			map("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, { desc = "[D]iff this" })

			map("n", "<leader>hQ", function()
				gitsigns.setqflist("all")
			end, { desc = "Set [Q]f list" })
			map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set [Q]f list" })

			-- Toggles
			map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle current line [B]lame" })
			map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "[T]oggle [D]eleted" })
			map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "[T]oggle [W]ord diff" })

			-- Text object
			map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select [H]unk"})
		end,
	},
}
