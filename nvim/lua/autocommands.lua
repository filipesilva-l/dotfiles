vim.cmd([[
    autocmd FileType json,hcl,xml,css,markdown,html,js,ts,nix setlocal tabstop=2 shiftwidth=2 softtabstop=2
]])

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "" },
	callback = function(details)
		local bufnr = details.buf

		if not pcall(vim.treesitter.start, bufnr) then
			return
		end

		vim.bo[bufnr].syntax = "on"
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldlevel = 99
		--vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

return {}
