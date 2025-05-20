vim.g.mapleader = " "
vim.g.localleader = " "
vim.g.have_nerd_fond = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250
vim.opt.timeoutlen = 1000
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.mouse = 'a'
vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.conceallevel = 0

-- Dart settings
vim.g.dart_style_guide = 2
vim.g.dart_trailing_comma_indent = true
vim.g.dart_format_on_save = 1
