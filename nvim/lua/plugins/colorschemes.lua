return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
    },
    {
        "rose-pine/neovim",
        lazy = false,
        name = "rose-pine",
        priority = 1000,
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        name = "nordic",
        priority = 1000,
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        enabled = true,
        name = "github-theme",
        priority = 1000,
    },
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_transparent_background = 1
            vim.g.gruvbox_material_foreground = 'mix'
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        opts = {
            transparent = true,
        },
    },
    {
        "thesimonho/kanagawa-paper.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            colors = {
                -- theme = {
                --     ink = {
                --         syn = {
                --             member = "#c4b28a",
                --             special2 = "#c4b28a",
                --         },
                --     },
                -- },
            },
        },
    },
    {
        "dgox16/oldworld.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "everviolet/nvim",
        name = "evergarden",
        priority = 1000,
        opts = {
            theme = {
                variant = "winter",
                accent = "green",
            },
            editor = {
                transparent_background = true,
                sign = {
                    color = "surface0",
                },
                float = {
                    color = "mantle",
                    invert_border = false,
                },
                completion = {
                    color = "surface0",
                },
            },
            overrides = function(theme)
                return {
                    FlashLabel = {
                        fg = "#c0696b",
                        bg = "#191e21",
                        style = { "bold" },
                    },
                    Search = {
                        fg = "#171c1f",
                        bg = "#c0696b",
                    },
                    CurSearch = {
                        fg = "#171c1f",
                        bg = "#c0696b",
                    },
                    IncSearch = {
                        fg = "#171c1f",
                        bg = "#c0696b",
                    },
                }
            end,
            style = {
                types = {},
            },
        },
    },
}
