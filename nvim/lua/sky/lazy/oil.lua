return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup {
            keymaps = {
                ["<C-p>"] = false,
                ["<C-h>"] = false,
            },
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
            view_options = {
                show_hidden = true,
            }
        }

        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        vim.keymap.set("n", "<space>-", require("oil").toggle_float)

        local oil = vim.api.nvim_create_augroup("SkyOiL", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = oil,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "oil" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "<C-h>", function()
                    vim.api.nvim_win_set_width(0, 40)
                    require("oil").open_preview {}
                end, opts)
            end,
        })
    end
}
