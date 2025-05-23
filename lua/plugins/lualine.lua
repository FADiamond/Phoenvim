return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- require("mini.icons").setup()
		--
		-- -- mock nvim-web-devicons to use mini.icons instead
		-- require("mini.icons").mock_nvim_web_devicons()
		require("lualine").setup({
			options = {
				-- theme = "onedark",
				extensions = { "neo-tree" },
			},
			-- sections = {
			-- 	lualine_z = {
			-- 		{
			-- 			function()
			-- 				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			-- 					if vim.api.nvim_buf_get_option(buf, "modified") then
			-- 						return "Unsaved buffers" -- any message or icon
			-- 					end
			-- 				end
			-- 				return ""
			-- 			end,
			-- 		},
			-- 	},
			-- },
		})
	end,
}
