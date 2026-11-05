return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		config = function()
			local gs = require("gitsigns")

			gs.setup({
				on_attach = function(bufnr)
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "go to next change" })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "go to previous change" })
				end,
			})
		end,
	},
	{
		"FabijanZulj/blame.nvim",
	},
	{
		"dlyongemallo/diffview.nvim",
		cmd = {
			"DiffviewClose",
			"DiffviewFileHistory",
			"DiffviewFocusFiles",
			"DiffviewLog",
			"DiffviewOpen",
			"DiffviewRefresh",
			"DiffviewToggleFiles",
		},
	},
	{
		"rafikdraoui/jj-diffconflicts",
	},
}
