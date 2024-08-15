return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup {
            keymaps = {
                ["<C-p>"] = false,
            },
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
            view_options = {
                show_hidden = true,
            }
        }

        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end
}
