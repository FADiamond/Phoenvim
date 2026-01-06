return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			-- keymap - copilot.lua
			--      accept = "<M-l>",
			--      next = "<M-]>",
			--      prev = "<M-[>",
			--      dismiss = "<C-]>",
			require("copilot").setup({
				suggestion = { auto_trigger = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			model = "claude-sonnet-4",
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			chat.setup(opts)

			local select = require("CopilotChat.select")
			vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = "*", range = true })

			-- Inline chat with Copilot
			vim.api.nvim_create_user_command("CopilotChatInline", function(args)
				chat.ask(args.args, {
					selection = select.visual,
					window = {
						layout = "float",
						relative = "cursor",
						width = 1,
						height = 0.4,
						row = 1,
					},
				})
			end, { nargs = "*", range = true })

			-- Restore CopilotChatBuffer
			vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
				chat.ask(args.args, { selection = select.buffer })
			end, { nargs = "*", range = true })

			-- Custom buffer for CopilotChat
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-*",
				callback = function()
					vim.opt_local.relativenumber = true
					vim.opt_local.number = true

					-- Get current filetype and set it to markdown if the current filetype is copilot-chat
					local ft = vim.bo.filetype
					if ft == "copilot-chat" then
						vim.bo.filetype = "markdown"
					end
				end,
			})
		end,
		event = "VeryLazy",
		keys = {
			-- Show prompts actions with telescope
			{
				"<leader>ap",
				function()
					require("CopilotChat").select_prompt({
						context = {
							"buffers",
						},
					})
				end,
				desc = "CopilotChat - Prompt actions",
			},
			{
				"<leader>ap",
				function()
					require("CopilotChat").select_prompt()
				end,
				mode = "x",
				desc = "CopilotChat - Prompt actions",
			},
			-- Code related commands
			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
			{ "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
			{ "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
			{ "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
			{ "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
			-- Chat with Copilot in visual mode
			{
				"<leader>av",
				":CopilotChatVisual",
				mode = "x",
				desc = "CopilotChat - Open in vertical split",
			},
			{
				"<leader>ax",
				":CopilotChatInline",
				mode = "x",
				desc = "CopilotChat - Inline chat",
			},
			-- Custom input for CopilotChat
			{
				"<leader>ai",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
					end
				end,
				desc = "CopilotChat - Ask input",
			},
			-- Generate commit message based on the git diff
			{
				"<leader>am",
				"<cmd>CopilotChatCommit<cr>",
				desc = "CopilotChat - Generate commit message for all changes",
			},
			-- Quick chat with Copilot
			{
				"<leader>aq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						vim.cmd("CopilotChatBuffer " .. input)
					end
				end,
				desc = "CopilotChat - Quick chat",
			},
			-- Fix the issue with diagnostic
			{ "<leader>af", "<cmd>CopilotChatFixError<cr>", desc = "CopilotChat - Fix Diagnostic" },
			-- Clear buffer and chat history
			{ "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
			-- Toggle Copilot Chat Vsplit
			{ "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
			-- Copilot Chat Models
			{ "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
			-- Copilot Chat Agents
			{ "<leader>aa", "<cmd>CopilotChatAgents<cr>", desc = "CopilotChat - Select Agents" },
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- optional = true,
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			file_types = { "markdown", "copilot-chat", "codecompanion" },
		},
		ft = { "markdown", "copilot-chat", "codecompanion" },
	},
	--  {
	--      "OXY2DEV/markview.nvim",
	--      lazy = false,
	--      config = function()
	-- local presets = require("markview.presets")
	--          require('markview').setup({
	--              preview = {
	--                  filetypes = { "markdown", "codecompanion" },
	--                  ignore_buftypes = {},
	--              },
	--              markdown = {
	--                  headings = presets.headings.simple,
	-- 		tables = presets.tables.rounded
	--              },
	--              ui = {
	--                  hover = {
	--                      show_icon_column = false, -- disables the side column with icon in hover
	--                  },
	--              },
	--          })
	--      end
	--  },
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			strategies = {
				chat = {
					adapter = {
						name = "copilot",
						model = "claude-sonnet-4",
					},
				},
			},
			display = {
				action_palette = {
					provider = "snacks",
				},
			},
		},
	},
	{
		"johnseth97/codex.nvim",
		lazy = true,
		cmd = { "Codex", "CodexToggle" }, -- Optional: Load only on command execution
		keys = {
			{
				"<leader>ac", -- Change this to your preferred keybinding
				function()
					require("codex").toggle()
				end,
				desc = "Toggle Codex popup",
			},
		},
		opts = {
			keymaps = {
				toggle = nil, -- Keybind to toggle Codex window (Disabled by default, watch out for conflicts)
				quit = "<C-q>", -- Keybind to close the Codex window (default: Ctrl + q)
			}, -- Disable internal default keymap (<leader>cc -> :CodexToggle)
			border = "rounded", -- Options: 'single', 'double', or 'rounded'
			width = 0.8, -- Width of the floating window (0.0 to 1.0)
			height = 0.8, -- Height of the floating window (0.0 to 1.0)
			model = nil, -- Optional: pass a string to use a specific model (e.g., 'o3-mini')
			autoinstall = true, -- Automatically install the Codex CLI if not found
		},
	},
}
