vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.cmd.set "filetype=term"
    end,
})

