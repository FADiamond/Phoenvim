return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			themes = {
				-- OneDark themes
				{
					name = "onedark",
					colorscheme = "onedark",
					before_load = function()
						require("onedark").setup({
							style = "warmer",
						})
					end,
				},
				-- Catppuccin themes
				{
					name = "Catppuccin Macchiato",
					colorscheme = "catppuccin-macchiato",
					before_load = function()
						require("catppuccin").setup({
							flavour = "macchiato",
						})
					end,
				},
				{
					name = "Catppuccin Frappe",
					colorscheme = "catppuccin-frappe",
					before_load = function()
						require("catppuccin").setup({
							flavour = "frappe",
						})
					end,
				},
				{
					name = "Catppuccin Mocha",
					colorscheme = "catppuccin-mocha",
					before_load = function()
						require("catppuccin").setup({
							flavour = "mocha",
						})
					end,
				},
				{
					name = "Bluloco Dark",
					colorscheme = "bluloco",
					before_load = function()
						require("bluloco").setup({
							style = "dark",
						})
					end,
				},
				-- Nordic theme
				{
					name = "Nordic",
					colorscheme = "nordic",
					before_load = function()
						require("nordic").load()
					end,
				},
				-- JB theme
				{
					name = "JB Dark",
					colorscheme = "jb",
				},

				-- GitHub themes
				{
					name = "GitHub Dark",
					colorscheme = "github_dark",
					before_load = function()
						require("github-theme").setup({})
					end,
				},
				{
					name = "nightwolf",
					colorscheme = "nightwolf",
				},
				{
					name = "Tokyo Night",
					colorscheme = "tokyonight"
				},
				{
					name = "Kanagawa",
					colorscheme = "kanagawa"
				}
			},
			livePreview = true,
})
		-- local themes_path = vim.fn.stdpath("config") .. "/lua/plugins/themes.lua"
		-- local themes_file = loadfile(themes_path)
		--
		-- local theme_names = {}
		-- if themes_file then
		-- 	local themes_table = themes_file()
		-- 	for _, theme in ipairs(themes_table) do
		-- 		if theme.name then
		-- 			table.insert(theme_names, theme.name)
		-- 		end
		-- 	end
		-- end
		--
		-- require("themery").setup({
		-- 	themes = theme_names, -- Automatically populated list of themes
		-- 	livePreview = true, -- Apply theme while picking. Default to true.
		-- })
	end,
}
