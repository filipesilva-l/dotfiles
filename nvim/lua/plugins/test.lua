return {
    {
        "nvim-neotest/neotest",
        enabled = false,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nsidorenco/neotest-vstest",
        },
        config = function()
            local neotest = require("neotest")

            neotest.setup({
                discovery = {
                    enabled = false,
                    concurrent = 1,
                },
                running = {
                    concurrent = true,
                },
                diagnostic = {
                    enabled = true,
                    severity = vim.diagnostic.severity.INFO,
                },
                summary = {
                    animated = false,
                },
                adapters = {
                    require("neotest-vstest"),
                },
            })

            vim.keymap.set("n", "<leader>tn", function()
                neotest.run.run()
            end, { desc = "run nearest test" })

            vim.keymap.set("n", "<leader>tf", function()
                neotest.run.run(vim.fn.expand("%"))
            end, { desc = "run test in file" })

            vim.keymap.set("n", "<leader>td", function()
                neotest.run.run({ strategy = "dap" })
            end, { desc = "debug nearest test" })
        end,
    },
}
