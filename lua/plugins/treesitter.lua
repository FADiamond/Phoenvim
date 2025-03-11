return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            auto_install = true,
            ensure_installed = {
                "lua",
                "python",
                "c",
                "cpp",
                "typescript",
                "javascript",
                "vue",
                "html",
                "css",
                "json",
                "yaml",
                "markdown",
                "markdown_inline",
                "tsx",
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
