vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.kitty_navigator_enable_stack_layout = 1

vim.o.number = true
vim.o.relativenumber = true

vim.o.scrolloff = 5

vim.o.signcolumn = "yes"

vim.o.expandtab = true

vim.o.clipboard = "unnamedplus"

vim.o.undofile = true

vim.o.hlsearch = false

vim.o.guicursor = ""
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = false

vim.o.termguicolors = true

vim.opt.updatetime = 300

vim.wo.signcolumn = "yes"

vim.o.ignorecase = true
vim.o.smartcase = true

vim.filetype.add({
	extension = {
		mdx = "markdown",
	},
})

vim.o.sessionoptions = "buffers,curdir"
