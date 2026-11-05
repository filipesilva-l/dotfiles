local M = {}

local ignored_filetypes = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

function M.setup_format_on_save(client, bufnr)
    if client == nil or client.supports_method("textDocument/formatting") then
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

        if ignored_filetypes[filetype] then
            return
        end

        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end

return M
