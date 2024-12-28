return {
    "ptzz/lf.vim",
    dependencies = {
        "voldikss/vim-floaterm"
    },
    config = function()
        vim.g.lf_map_keys = 0
        vim.g.floaterm_opener = "e"
        vim.g.floaterm_width = 100
        vim.g.floaterm_height = 30
        vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")
    end,
}
