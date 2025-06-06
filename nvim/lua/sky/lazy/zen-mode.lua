return {
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                window = {
                    width = 90,
                    options = {
                        laststatus = 0,
                    }
                },
                on_close = function()
                    vim.opt.laststatus = 3
                    vim.opt.number = true
                    vim.opt.relativenumber = true
                    vim.opt.wrap = false
                    vim.wo.colorcolumn = "80"
                end,
            }


            vim.keymap.set("n", "<leader>zz", function()
                require("zen-mode").toggle()
                vim.wo.wrap = false
            end)

            vim.keymap.set("n", "<leader>zZ", function()
                require("zen-mode").toggle()
                vim.wo.number = false
                vim.wo.colorcolumn = "0"
                vim.wo.relativenumber = false
                vim.wo.wrap = true

                vim.keymap.set("n", "j", "gj")
                vim.keymap.set("n", "k", "gk")
            end)
        end
    }
}
