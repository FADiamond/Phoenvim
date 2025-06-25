return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	opts = {
		-- delay between pressing a key and opening which-key (milliseconds)
		-- this setting is independent of vim.opt.timeoutlen
		delay = 600,
		icons = {
			-- set icon mappings to true if you have a Nerd Font
			mappings = vim.g.have_nerd_font,
			-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
			-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
			keys = vim.g.have_nerd_font and {} or {
				Up = "<Up> ",
				Down = "<Down> ",
				Left = "<Left> ",
				Right = "<Right> ",
				C = "<C-…> ",
				M = "<M-…> ",
				D = "<D-…> ",
				S = "<S-…> ",
				CR = "<CR> ",
				Esc = "<Esc> ",
				ScrollWheelDown = "<ScrollWheelDown> ",
				ScrollWheelUp = "<ScrollWheelUp> ",
				NL = "<NL> ",
				BS = "<BS> ",
				Space = "<Space> ",
				Tab = "<Tab> ",
				F1 = "<F1>",
				F2 = "<F2>",
				F3 = "<F3>",
				F4 = "<F4>",
				F5 = "<F5>",
				F6 = "<F6>",
				F7 = "<F7>",
				F8 = "<F8>",
				F9 = "<F9>",
				F10 = "<F10>",
				F11 = "<F11>",
				F12 = "<F12>",
			},
		},

		-- Document existing key chains
		spec = {
			{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>o", group = "[O]bsidian" },
			{ "<leader>G", group = "[G]it" },
		-- 	{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>f", group = "[F]lutter" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>J", group = "[J]ava" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>h", group = "[H]arpoon and Git [H]unk", mode = { "n", "v" } },
			{ "<leader>g", group = "[G]o to" },
			{ "<leader>b", group = "[B]uffer" },
		},
		config = function ()
			local wk = require("which-key")
			wk.setup()

			wk.register({
				["<C-b>"] = { "Scroll docs up" },
				["<C-f>"] = { "Scroll docs down" },
				["<C-Space>"] = { "Trigger completion" },
				["<C-e>"] = { "Abort/close completion" },
				["<CR>"] = { "Confirm completion" },
			})


		end
	},
}
