return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- Lua
                null_ls.builtins.formatting.stylua,

                -- Python
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                -- null_ls.builtins.diagnostics.pylint,

                -- Javascript
                null_ls.builtins.formatting.prettier,
                require("none-ls.diagnostics.eslint_d"),

                -- Typst
                null_ls.builtins.formatting.typstfmt,

            },
        })
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })

    end,
}
