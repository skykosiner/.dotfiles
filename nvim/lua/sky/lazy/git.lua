return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
            vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git("pull") end)
            vim.keymap.set("n", "<leader>gl", function() vim.cmd.Git("log") end)

            local Sky_Fugitive = vim.api.nvim_create_augroup("Sky_Fugitive", {})

            local autocmd = vim.api.nvim_create_autocmd
            autocmd("BufWinEnter", {
                group = Sky_Fugitive,
                pattern = "*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = { buffer = bufnr, remap = false }

                    vim.keymap.set("n", "<leader>p", function()
                        vim.cmd.Git("push")
                    end, opts)

                    vim.keymap.set("n", "q", ":q!<CR>", opts)

                    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
                end,
            })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {}

            vim.keymap.set("n", "[g", ":Gitsigns prev_hunk<CR>")
            vim.keymap.set("n", "]g", ":Gitsigns next_hunk<CR>")
        end,
    }
}
