return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter")
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
                "bash",
                "diff",
                -- Git related
            },
            highlight = { enable = true },
            indent = { enable = true },
            ignore_install = { "dart" },
        })
    end,
}
