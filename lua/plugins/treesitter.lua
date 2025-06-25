return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
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
                "bash",
                "diff",
                -- Git related
            },
            highlight = { enable = true },
            indent = { enable = true },
            ignore_install = { "dart", "gitcommit", "vimdoc", "ssh_config", },
            disable = { "gitcommit", "vimdoc", "ssh_config" }
        })
    end,
}
