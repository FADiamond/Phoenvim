return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "ts_ls", "basedpyright", "pylsp", "tinymist" },
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({

				capabilities = capabilities,
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
			})
			-- lspconfig.pyright.setup({})
			lspconfig.basedpyright.setup({
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.tinymist.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition" })
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			vim.keymap.set({ "n", "v" }, "<leader>cr", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })

			vim.diagnostic.config({
				underline = true,
				sings = true,
				virtual_text = false, -- or true if you prefer inline messages
				update_in_insert = true,
				float = {
					border = "rounded",
				},
			})
			-- Go to next/previous diagnostic
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

			-- Show a floating diagnostics window
			vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "[C]ode [D]iagnostics" })

			-- Error: red squiggly line
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
				undercurl = true, -- squiggly style
				sp = "#db4b4b", -- color for the curl
			})

			-- Warning: yellow/orange squiggly line
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
				undercurl = true,
				sp = "#e0af68",
			})

			-- Info: (optional) blue-ish
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
				undercurl = true,
				sp = "#0db9d7",
			})

			-- Hint: (optional) green-ish
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
				undercurl = true,
				sp = "#1abc9c",
			})

			-- 			-- A table of your preferred icons (Nerd Fonts or any unicode characters)
			-- 			local signs = {
			-- 				Error = "", -- e.g. nf-mdi-close_circle or nf-fa-times_circle
			-- 				Warn = "", -- e.g. nf-fa-exclamation_triangle
			-- 				Hint = "", -- e.g. nf-fa-lightbulb_o
			-- 				Info = "", -- e.g. nf-fa-info_circle
			-- }
			--
			-- 			for type, icon in pairs(signs) do
			-- 				local hl = "DiagnosticSign" .. type
			-- 				vim.fn.sign_define(hl, {
			-- 					text = icon,
			-- 					texthl = hl, -- Use the same highlight group as the name
			-- 					numhl = "", -- If you prefer a highlight for line numbers, define it here
			-- 				})
			-- 			end
		end,
	},
}
