vim.loader.enable()

require("options")
require("keymaps")
require("highlight-on-yank")
require("autocommands")

require("lazy-setup")

require("commands.apresentar")

vim.lsp.enable("rust_analyzer")
vim.lsp.enable("svelte")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("clangd")
vim.lsp.enable("angularls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("astro")
vim.lsp.enable("gopls")
vim.lsp.enable("denols")
