-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function ()
-- 		vim.cmd.colorscheme("catppuccin-macchiato")
-- 	end
-- }
return {
    "navarasu/onedark.nvim",
    name = "onedark",
    priority = 1000,
    config = function()
        require("onedark").setup({
            style = "warmer",
        })
        vim.cmd.colorscheme("onedark")
    end,
}
