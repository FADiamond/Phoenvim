return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            auto_install = true
        }
        -- config = function()
        --     require("mason-lspconfig").setup({
        --         ensure_installed = { "lua_ls", "ts_ls", "basedpyright", "pylsp", "pyright" }
        --     })
        -- end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()


            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities 
            })
            lspconfig.ts_ls.setup({

                capabilities = capabilities 
            })
            lspconfig.pylsp.setup({
                capabilities = capabilities 
            })
            -- lspconfig.pyright.setup({})
            lspconfig.basedpyright.setup({
                capabilities = capabilities 
            })

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }
}
