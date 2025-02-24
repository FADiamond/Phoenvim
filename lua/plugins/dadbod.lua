return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.keymap.set("n", "<leader>tu", "<cmd>DBUIToggle<CR>", {
				desc = "[T]oggle Dadbod UI",
			})
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_database_icon = 1
		end,
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		ft = { "sql", "mysql", "plsql" },
		dependencies = {
			"tpope/vim-dadbod",
		},
		config = function()
			vim.g.vim_dadbod_completion_enable = 1
		end,
	},
}
