local format_on_save = require("utils.lsp_format_on_save")

local function set_keymaps()
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "go to implementation" })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "go to references" })

	vim.keymap.set(
		"n",
		"gvD",
		"<c-w>v<cmd>lua vim.lsp.buf.declaration()<CR><c-w>l",
		{ desc = "go to declaration with vsplit" }
	)
	vim.keymap.set(
		"n",
		"gvd",
		"<c-w>v<cmd>lua vim.lsp.buf.definition()<CR><c-w>l",
		{ desc = "go to definition with vsplit" }
	)
	vim.keymap.set(
		"n",
		"gvi",
		"<c-w>v<cmd>lua vim.lsp.buf.implementation()<CR><c-w>l",
		{ desc = "go to implementation with vsplit" }
	)

	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "go to previous diagnostic" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "go to next diagnostic" })
	vim.keymap.set("n", "gL", vim.diagnostic.open_float, { desc = "show diagnostic in curr line" })

	vim.keymap.set("n", "<leader>ld", vim.lsp.buf.type_definition, { desc = "type Definition" })
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "rename" })
	vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "code actions" })
	vim.keymap.set("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "format" })

	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "rename" })
end

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		config = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		event = "VeryLazy",
		config = function()
			set_keymaps()

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
				on_attach = function(client, bufnr)
					format_on_save.setup_format_on_save(client, bufnr)
				end,
			})

			vim.lsp.config("svelte", { capabilities = capabilities })

			vim.lsp.config("tailwindcss", { capabilities = capabilities })

			vim.lsp.config("denols", { capabilities = capabilities })

			vim.lsp.config("clangd", { capabilities = capabilities })

			vim.lsp.config("angularls", { capabilities = capabilities })

			vim.lsp.config("ts_ls", { capabilities = capabilities })

			vim.lsp.config("nil_ls", { capabilities = capabilities })

			vim.lsp.config("lua_ls", { capabilities = capabilities })

			vim.lsp.config("astro", { capabilities = capabilities })

			vim.lsp.config("gopls", {
				capabilities = capabilities,
				settings = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			})
		end,
	},
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		opts = {
			filewatching = "roslyn",
		},
	},
}
