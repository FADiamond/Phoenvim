return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local statusline = require("arrow.statusline") -- from arrow documentation
		local function arrow_status() -- from lualine documentation
			return statusline.text_for_statusline_with_icons()
		end
		require("lualine").setup({
			options = {
				-- theme = "onedark",
				extensions = { "neo-tree" },
				globalstatus = true,
			},
			sections = {
				-- lualine_b = { "branch", "diff", "diagnostics", arrow_status },
				lualine_c = { { 'filename', separator = '' }, arrow_status }
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
			},
		})
	end,
}
