return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		-- 'nvim-telescope/telescope.nvim' or 'ibhagwan/fzf-lua' or 'folke/snacks.nvim'
		-- are highly recommended for a better experience
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local function get_secret_path(secret_guid)
				local path = ""
				local home_dir = vim.fn.expand("~")
				if require("easy-dotnet.extensions").isWindows() then
					local secret_path = home_dir
						.. "\\AppData\\Roaming\\Microsoft\\UserSecrets\\"
						.. secret_guid
						.. "\\secrets.json"
					path = secret_path
				else
					local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
					path = secret_path
				end
				return path
			end

			local dotnet = require("easy-dotnet")
			-- Options are not required
			dotnet.setup({
				--Optional function to return the path for the dotnet sdk (e.g C:/ProgramFiles/dotnet/sdk/8.0.0)
				-- easy-dotnet will resolve the path automatically if this argument is omitted, for a performance improvement you can add a function that returns a hardcoded string
				-- You should define this function to return a hardcoded path for a performance improvement 🚀
				get_sdk_path = get_sdk_path,
				---@type TestRunnerOptions
				test_runner = {
					---@type "split" | "float" | "buf"
					viewmode = "float",
					enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
					noBuild = true,
					noRestore = true,
					icons = {
						passed = "",
						skipped = "",
						failed = "",
						success = "",
						reload = "",
						test = "",
						sln = "󰘐",
						project = "󰘐",
						dir = "",
						package = "",
					},
					mappings = {
						run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
						filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
						debug_test = { lhs = "<leader>d", desc = "debug test" },
						go_to_file = { lhs = "g", desc = "got to file" },
						run_all = { lhs = "<leader>R", desc = "run all tests" },
						run = { lhs = "<leader>r", desc = "run test" },
						peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
						expand = { lhs = "o", desc = "expand" },
						expand_node = { lhs = "E", desc = "expand node" },
						expand_all = { lhs = "-", desc = "expand all" },
						collapse_all = { lhs = "W", desc = "collapse all" },
						close = { lhs = "q", desc = "close testrunner" },
						refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
					},
					--- Optional table of extra args e.g "--blame crash"
					additional_args = {},
				},
				---@param action "test" | "restore" | "build" | "run"
				terminal = function(path, action, args)
					local commands = {
						run = function()
							return string.format("dotnet run --project %s %s", path, args)
						end,
						test = function()
							return string.format("dotnet test %s %s", path, args)
						end,
						restore = function()
							return string.format("dotnet restore %s %s", path, args)
						end,
						build = function()
							return string.format("dotnet build %s %s", path, args)
						end,
						watch = function()
							return string.format("dotnet watch --project %s %s", path, args)
						end,
					}

					local command = commands[action]() .. "\r"
					vim.cmd("vsplit")
					vim.cmd("term " .. command)
				end,
				secrets = {
					path = get_secret_path,
				},
				csproj_mappings = true,
				fsproj_mappings = true,
				auto_bootstrap_namespace = {
					--block_scoped, file_scoped
					type = "block_scoped",
					enabled = true,
				},
				-- choose which picker to use with the plugin
				-- possible values are "telescope" | "fzf" | "snacks" | "basic"
				-- if no picker is specified, the plugin will determine
				-- the available one automatically with this priority:
				-- telescope -> fzf -> snacks ->  basic
				picker = "telescope",
			})

			-- Example command
			vim.api.nvim_create_user_command("Secrets", function()
				dotnet.secrets()
			end, {})

			-- Example keybinding
			vim.keymap.set("n", "<C-p>", function()
				dotnet.run_project()
			end)
		end,
	},
	-- {
	--   "GustavEikaas/easy-dotnet.nvim",
	--   dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	--   config = function()
	--     local logPath = vim.fn.stdpath("data") .. "/easy-dotnet/build.log"
	--     local dotnet = require("easy-dotnet")
	--
	--     dotnet.setup({
	--       terminal = function(path, action)
	--         local commands = {
	--           run = function()
	--             return "dotnet run --project " .. path
	--           end,
	--           test = function()
	--             return "dotnet test " .. path
	--           end,
	--           restore = function()
	--             return "dotnet restore --configfile " .. os.getenv("NUGET_CONFIG") .. " " .. path
	--           end,
	--           build = function()
	--             return "dotnet build  " .. path .. " /flp:v=q /flp:logfile=" .. logPath
	--           end,
	--         }
	--
	--         local function filter_warnings(line)
	--           if not line:find("warning") then
	--             return line:match("^(.+)%((%d+),(%d+)%)%: (.+)$")
	--           end
	--         end
	--
	--         local overseer_components = {
	--           { "on_complete_dispose", timeout = 30 },
	--           "default",
	--           { "unique", replace = true },
	--           {
	--             "on_output_parse",
	--             parser = {
	--               diagnostics = {
	--                 { "extract", filter_warnings, "filename", "lnum", "col", "text" },
	--               },
	--             },
	--           },
	--           {
	--             "on_result_diagnostics_quickfix",
	--             open = true,
	--             close = true,
	--           },
	--         }
	--
	--         if action == "run" or action == "test" then
	--           table.insert(overseer_components, { "restart_on_save", paths = { LazyVim.root.git() } })
	--         end
	--
	--         local command = commands[action]()
	--         local task = require("overseer").new_task({
	--           strategy = {
	--             "toggleterm",
	--             use_shell = false,
	--             direction = "horizontal",
	--             open_on_start = false,
	--           },
	--           name = action,
	--           cmd = command,
	--           components = overseer_components,
	--         })
	--         task:start()
	--       end
	--     })
	--   end,
	-- },
	-- lazy.nvim
}
