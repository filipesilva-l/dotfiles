return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
            require("mini.fuzzy").setup()
            require("mini.bufremove").setup()
            require("mini.trailspace").setup()
        end,
    },
}
