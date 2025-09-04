return {
    "folke/zen-mode.nvim",
    dependencies = {
        "folke/twilight.nvim",
    },
    config = function()
        require("twilight").setup {
            dimming = {
                alpha = 0.20,
                term_bg = "#2e3440"
            },
        }

        require("zen-mode").setup {
            window = {
                width = 90,
                options = {
                    laststatus = 0,
                }
            },
            pluigns = {
                twilight = { enabled = true },
                tmux = { enabled = false },
            },
            on_open = function(_)
                vim.fn.system([[tmux set status off]])
                vim.fn.system(
                    [[tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z]])
            end,
            on_close = function(_)
                vim.fn.system([[tmux set status on]])
                vim.fn.system(
                    [[tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z]])
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
