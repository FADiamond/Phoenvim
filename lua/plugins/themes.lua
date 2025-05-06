return {
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "warmer",
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
			})
		end,
	},
	{
		"uloco/bluloco.nvim",
		name = "bluloco",
		lazy = false,
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			require("bluloco").setup({
				style = "dark",
			})
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		name = "nordic",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	{
		"nickkadutskyi/jb.nvim",
		name = "jb",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			-- require("jb").setup({transparent = true})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({})
		end,
	},
	{
		"ricardoraposo/nightwolf.nvim",
		name = "nightwolf",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("nightwolf").setup({
				theme = "gray"
			})
		end,
	},
}
