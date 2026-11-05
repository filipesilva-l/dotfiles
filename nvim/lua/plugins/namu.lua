return {
	"bassamsdata/namu.nvim",
	event = "VeryLazy",
	config = function()
		require("namu").setup({
			namu_symbols = {
				enable = true,
				options = {},
			},
			ui_select = { enable = false },
			colorscheme = {
				enable = true,
				options = {
					persist = true,
					write_shada = false,
				},
			},
		})

		vim.keymap.set("n", "<leader>ls", ":Namu symbols<cr>", {
			desc = "Jump to LSP symbol",
			silent = true,
		})
		vim.keymap.set("n", "<leader>sc", ":Namu colorscheme<cr>", {
			desc = "Colorscheme Picker",
			silent = true,
		})
	end,
}
