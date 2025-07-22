return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"williamboman/mason.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		require("mason-null-ls").setup({
			ensure_installed = {
				-- "prettier",
				"stylua",
				-- "black",
				-- "isort",
				"eslint_d",
				-- "typstfmt",
			},
			automatic_installation = true,
		})

		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Python
				null_ls.builtins.diagnostics.pylint.with({
					command = "pylint",
					args = { "--rcfile=pylintrc.toml", "--output-format=json", "-" },
					filetypes = {
						"python"
					}
				}),
				-- null_ls.builtins.diagnostics.pylint,
				-- null_ls.builtins.formatting.ruff,
				null_ls.builtins.formatting.black.with({
					filetypes = {
						"python"
					}
				}),
				null_ls.builtins.formatting.isort.with({
					filetypes = {
						"python"
					}
				}),
				-- Javascript/TypeScript/Vue
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"css",
						"scss",
						"html",
						"json",
						"yaml",
						"markdown",
					},
					disabled_filetypes = { "dart" },
					prefer_local = "node_modules/.bin",
				}),

				-- ESLint for JavaScript/TypeScript/Vue
				-- null_ls.builtins.diagnostics.eslint_d.with({
				-- 	filetypes = {
				-- 		"javascript",
				-- 		"javascriptreact",
				-- 		"typescript",
				-- 		"typescriptreact",
				-- 		"vue",
				-- 	},
				-- 	prefer_local = "node_modules/.bin",
				-- }),
				-- null_ls.builtins.code_actions.eslint_d.with({
				-- 	filetypes = {
				-- 		"javascript",
				-- 		"javascriptreact",
				-- 		"typescript",
				-- 		"typescriptreact",
				-- 		"vue",
				-- 	},
				-- 	prefer_local = "node_modules/.bin",
				-- }),

				-- CSS/SCSS linting
				null_ls.builtins.diagnostics.stylelint.with({
					filetypes = { "css", "scss" },
					prefer_local = "node_modules/.bin",
				}),
				require("none-ls.diagnostics.eslint").with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
					},
				}),
			},
		})
		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
	end,
}
