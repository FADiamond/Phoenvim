vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Autocmd that fires whenever you open a dadbod output buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dbout",
  callback = function()
    vim.opt_local.foldenable = false  -- Prevent SQL tables from autofolding

    -- Set keymaps for horizontal scrolling
    -- "zh" scrolls view half a character left, "zH" is full width, etc.
    vim.keymap.set("n", "<S-h>", "zH", { buffer = true, desc = "Scroll full window left" })
    vim.keymap.set("n", "<S-l>", "zL", { buffer = true, desc = "Scroll full window right" })

    -- Alternatively for just half-screen:
    -- vim.keymap.set("n", "<S-h>", "zh", { buffer = true, desc = "Scroll half-step left" })
    -- vim.keymap.set("n", "<S-l>", "zl", { buffer = true, desc = "Scroll half-step right" })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.dart",
  callback = function()
    -- Only run if file contains @riverpod annotation
    local lines = vim.api.nvim_buf_get_lines(0, 0, 50, false) -- Check first 50 lines
    local has_riverpod = false
    
    for _, line in ipairs(lines) do
      if line:match("@riverpod") then
        has_riverpod = true
        break
      end
    end
    
    if has_riverpod then
      require('snacks').notify("Auto-building Riverpod providers...", { type = "info", timeout = 2000 })
      vim.fn.jobstart("dart run build_runner build", {
        on_exit = function(_, exit_code)
          if exit_code == 0 then
            require('snacks').notify("Auto-build completed!", { type = "success", timeout = 2000 })
          end
        end
      })
    end
  end,
})

-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   pattern = "dart",
--   callback = function ()
--     -- local flutter_running = vim.fn.exists("g:flutter_tools_running") == 1 and vim.g.flutter_tools_running
--     -- if flutter_running then
--     --   -- Stop the Flutter app
--       vim.cmd("FlutterQuit")
--     -- end
--   end,
--   desc = "Quit Flutter app when exiting Neovim"
-- })

-- vim.cmd [[
--     augroup jdtls_lsp
--         autocmd!
--         autocmd FileType java lua require'ftplugin.jdtls'.setup_jdtls()
--     augroup end
-- ]]


-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   desc = "Enforce 4-space indentation across all filetypes",
--   pattern = "*",
--   callback = function()
--     -- Skip certain filetypes that should have their own settings
--     local ft = vim.bo.filetype
--     local skip_filetypes = {
--       -- Add any exceptions here (filetypes that should NOT use 4 spaces)
--     }
--
--     if not vim.tbl_contains(skip_filetypes, ft) then
--       vim.bo.tabstop = 4
--       vim.bo.softtabstop = 4
--       vim.bo.shiftwidth = 4
--       vim.bo.expandtab = true
--     end
--   end
-- })

