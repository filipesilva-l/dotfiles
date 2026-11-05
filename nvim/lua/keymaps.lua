vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ "n", "v" }, "gh", "^", { noremap = true, silent = true, desc = "go to the start of the line" })
vim.keymap.set({ "n", "v" }, "gl", "$", { noremap = true, silent = true, desc = "go to the end of the line" })

vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true, desc = "ident to left" })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true, desc = "ident to right" })

vim.api.nvim_set_keymap("n", "<S-h>", ":bp<CR>", { noremap = true, silent = true, desc = "swich to previous buffer" })
vim.api.nvim_set_keymap("n", "<S-l>", ":bn<CR>", { noremap = true, silent = true, desc = "swich to next buffer" })

vim.api.nvim_set_keymap("n", "<Tab>", "<Tab>", { noremap = true, silent = true, desc = "swich to previous buffer" })
vim.api.nvim_set_keymap("n", "<S-Tab>", "<S-Tab>", { noremap = true, silent = true, desc = "swich to next buffer" })

vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
	"n",
	"<leader>c",
	":lua MiniBufremove.delete()<CR>",
	{ noremap = true, silent = true, desc = "close buffer" }
)
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "write buffer" })
