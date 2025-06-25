return {
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "warmer",
				highlights = {
						
				}
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				-- flavour = "macchiato",
				flavour = "mocha",
				color_overrides = {
					mocha = {
						rosewater = "#ffc0b9",
						flamingo = "#f5aba3",
						pink = "#f592d6",
						mauve = "#c0afff",
						red = "#ea746c",
						maroon = "#ff8595",
						peach = "#fa9a6d",
						yellow = "#ffe081",
						green = "#99d783",
						teal = "#47deb4",
						sky = "#00d5ed",
						sapphire = "#00dfce",
						blue = "#00baee",
						lavender = "#abbff3",
						text = "#cccccc",
						subtext1 = "#bbbbbb",
						subtext0 = "#aaaaaa",
						overlay2 = "#999999",
						overlay1 = "#888888",
						overlay0 = "#777777",
						surface2 = "#666666",
						surface1 = "#555555",
						surface0 = "#444444",
						base = "#202020",
						mantle = "#222222",
						crust = "#333333",
					},
				},
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
				theme = "gray",
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
	},
}
