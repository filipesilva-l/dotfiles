local format_on_save = require("utils.lsp_format_on_save")

return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			on_attach = function(client, bufnr)
				format_on_save.setup_format_on_save(client, bufnr)
			end,
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.nixfmt,
				null_ls.builtins.formatting.csharpier.with({ filetypes = { "xml", "cs" } }),
				-- null_ls.builtins.formatting.prettier.with({
				-- 	filetypes = { "astro", "svelte", "typescript", "markdown" },
				-- }),
			},
		})
	end,
}
