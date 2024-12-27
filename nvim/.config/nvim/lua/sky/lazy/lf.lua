return {
    "lmburns/lf.nvim",
    dependencies = {
        "akinsho/toggleterm.nvim"
    },
    config = function()
        -- This feature will not work if the plugin is lazy-loaded
        vim.g.lf_netrw = 1

        require("lf").setup({
            escape_quit = false,
            border = "rounded",
        })

        vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")
    end,
}
