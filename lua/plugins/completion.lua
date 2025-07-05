return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			-- Load snippet paths for our custom snippets BEFORE initializing luasnip
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = vim.fn.stdpath("config") .. "/lua/snippets",
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "./lua/plugins/snippets/flutter-riverpod-snippets" },
			})

			cmp.register_source("easy-dotnet", require("easy-dotnet").package_completion_source)
			local cmp_kinds = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = "",
			}
			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
			end
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				-- window = {
				-- 	completion = cmp.config.window.bordered(),
				-- 	documentation = cmp.config.window.bordered(),
				-- },
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
					},
					documentation = {
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:PmenuSel,Search:None",
					},
				},
				formatting = {
					fields = { "menu", "abbr", "kind" },
					format = function(entry, item)
						local menu_icon = {
							nvim_lsp = "λ",
							luasnip = "⋗",
							copilot = "",
							buffer = "Ω",
							path = "🖫",
						}
						item.menu = cmp_kinds[item.kind]
						return item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
						if cmp.visible() then
							local entry = cmp.get_selected_entry()
							if not entry then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
							end
							cmp.confirm()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s", "c" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					-- { name = "copilot" },
					{ name = "vim-dadbod-completion" },
					{ name = "easy-dotnet" },
				}, {
					{ name = "buffer" },
				}),
				-- sorting = {
				-- 	-- TODO: possibly remove this in the future if the completion priority sucks
				-- 	comparators = {
				-- 		cmp.config.compare.offset,
				-- 		cmp.config.compare.exact,
				-- 		cmp.config.compare.score,
				--
				-- 		-- copied from cmp-under, but I don't think I need the plugin for this.
				-- 		-- I might add some more of my own.
				-- 		function(entry1, entry2)
				-- 			local _, entry1_under = entry1.completion_item.label:find("^_+")
				-- 			local _, entry2_under = entry2.completion_item.label:find("^_+")
				-- 			entry1_under = entry1_under or 0
				-- 			entry2_under = entry2_under or 0
				-- 			if entry1_under > entry2_under then
				-- 				return false
				-- 			elseif entry1_under < entry2_under then
				-- 				return true
				-- 			end
				-- 		end,
				--
				-- 		cmp.config.compare.kind,
				-- 		cmp.config.compare.sort_text,
				-- 		cmp.config.compare.length,
				-- 		cmp.config.compare.order,
				-- 	},
				-- },
			})
			local autocomplete_group = vim.api.nvim_create_augroup("vimrc_autocompletion", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
				end,
				group = autocomplete_group,
			})
		end,
	},
}
