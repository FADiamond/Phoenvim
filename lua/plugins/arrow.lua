return {
	"otavioschwanck/arrow.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		-- or if using `mini.icons`
		-- { "echasnovski/mini.icons" },
	},
	opts = {
		show_icons = true,
		leader_key = ";", -- Recommended to be a single key
		buffer_leader_key = "m", -- Per Buffer Mappings
		separate_save_and_remove = true,
		mappings = {
			edit = "e",
			delete_mode = "d",
			clear_all_items = "C",
			toggle = "a", -- used as save if separate_save_and_remove is true
			open_vertical = "v",
			open_horizontal = "-",
			quit = "q",
			remove = "x", -- only used if separate_save_and_remove is true
			next_item = "]",
			prev_item = "[",
		},
		-- index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP",
		index_keys = "sfghjkl123456789zxcbnmZXVBNM,AFGHJKLwrtyuiopWRTYUIOP",
	},
}
