local group = vim.api.nvim_create_augroup("SKY", { clear = true })

-- Make sure the file type is set to term on terminal open  and unset all the numbmer stuff
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.scrolloff = 0
        vim.cmd.set "filetype=term"
    end,
    group = group
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 50,
        })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = vim.fn.expand("$HOME/.dotfiles/.bookm"),
    callback = function()
        vim.cmd("!~/.local/bin/bookmarks --lf && ~/.local/bin/bookmarks --shell")
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = vim.fn.expand("$HOME/.dotfiles/.bookmfiles"),
    callback = function()
        vim.cmd("!~/.local/bin/bookmarks --shell-files")
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = group,
    pattern = "*",
    callback = function()
        vim.opt.cursorline = false
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    pattern = "*",
    callback = function()
        vim.opt.cursorline = true
    end,
})
