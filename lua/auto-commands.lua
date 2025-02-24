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
    -- Disable folding (so tables won't auto-fold)
    vim.opt_local.foldenable = false

    -- Set keymaps for horizontal scrolling
    -- "zh" scrolls view half a character left, "zH" is full width, etc.
    vim.keymap.set("n", "<S-h>", "zH", { buffer = true, desc = "Scroll full window left" })
    vim.keymap.set("n", "<S-l>", "zL", { buffer = true, desc = "Scroll full window right" })

    -- Alternatively for just half-screen:
    -- vim.keymap.set("n", "<S-h>", "zh", { buffer = true, desc = "Scroll half-step left" })
    -- vim.keymap.set("n", "<S-l>", "zl", { buffer = true, desc = "Scroll half-step right" })
  end,
})

