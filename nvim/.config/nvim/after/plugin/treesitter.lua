local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
