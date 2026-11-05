return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } },
    opts = {},
    keys = {
        {
            "<leader><leader>a",
            mode = "n",
            function()
                require("harpoon").list():add()
            end,
            desc = "Append current buffer",
        },
        {
            "<leader><leader>f",
            mode = "n",
            function()
                require("harpoon").ui:toggle_quick_menu(require("harpoon").list())
            end,
            desc = "List buffers",
        },
        {
            "<leader><leader>h",
            mode = "n",
            function()
                require("harpoon").list():select(1)
            end,
            desc = "Select buffer 1",
        },
        {
            "<leader><leader>j",
            mode = "n",
            function()
                require("harpoon").list():select(2)
            end,
            desc = "Select buffer 2",
        },
        {
            "<leader><leader>k",
            mode = "n",
            function()
                require("harpoon").list():select(3)
            end,
            desc = "Select buffer 3",
        },
        {
            "<leader><leader>l",
            mode = "n",
            function()
                require("harpoon").list():select(4)
            end,
            desc = "Select buffer 4",
        },
        {
            "<leader><leader>p",
            mode = "n",
            function()
                require("harpoon").list():prev()
            end,
            desc = "Toggle previous",
        },
        {
            "<leader><leader>n",
            mode = "n",
            function()
                require("harpoon").list():next()
            end,
            desc = "Toggle next",
        },
    },
}
