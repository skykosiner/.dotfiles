return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup {
            keymaps = {
                ["<C-p>"] = false,
            },
            view_options = {
                show_hidden = true,
            }
        }

        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end
}
