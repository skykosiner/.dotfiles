return {
    {
        dir = os.getenv("HOME") .. "/personal/statusline.nvim/",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            vim.opt.laststatus = 3

            require("statusline"):setup {
                background_color = "#7fa3c0",
                foreground_color = "#2e2e2e",
                lsp_info         = true,
                harpoon_info     = true,
                git_info         = true,
                show_icons       = true,
            }
        end
    }
}
