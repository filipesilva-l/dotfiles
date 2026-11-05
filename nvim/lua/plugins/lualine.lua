local function lsp_component()
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
	if #buf_clients == 0 then
		return "LSP Inactive"
	end

	local buf_client_names = {}

	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" and client.name ~= "copilot" then
			table.insert(buf_client_names, client.name)
		end
	end

	local language_servers = table.concat(buf_client_names, ", ")

	return language_servers
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local kanagawa_paper = require("lualine.themes.kanagawa-paper-ink")

		require("lualine").setup({
			options = {
				theme = kanagawa_paper,
				component_separators = { left = " ", right = " " },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					"encoding",
					"filetype",
					{ lsp_component },
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
