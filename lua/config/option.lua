-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Cursor and comment settings
vim.opt.guicursor = "a:block"
-- Disable automatic comment continuation
vim.opt.formatoptions = "jql"

-- general
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.foldmethod = "manual"
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"
vim.opt.guifont = "FiraCode Nerd Font:h14.5"

-- undotree
vim.opt.undofile = true

