vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear the search higlight" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wv", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown preview" })
vim.keymap.set("n", "<leader>m=", "<cmd>TableFormat<CR>", { desc = "Format markdown table" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })

vim.keymap.set("n", "<leader>tc", function()
  if vim.bo.filetype == "java" then
    require("jdtls").test_class();
  end
end, { desc = "[T]est [C]lass" })

vim.keymap.set("n", "<leader>tm", function()
  if vim.bo.filetype == "java" then
    require("jdtls").test_nearest_method();
  end
end, { desc = "[T]est [M]ethod" })
