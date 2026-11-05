return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    enabled = false,
    config = function()
        local bufferline = require("bufferline")

        bufferline.setup({
            options = {
                style_preset = bufferline.style_preset.default,
                right_mouse_command = false,
                close_icon = "",
                max_name_length = 24,
                custom_filter = function(buf_number, _)
                    if vim.bo[buf_number].filetype ~= "qf" then
                        return true
                    end
                end,
            },
        })
    end,
}
