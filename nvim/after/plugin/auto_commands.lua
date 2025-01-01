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

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local c = vim.lsp.get_client_by_id(args.data.client_id)
        if not c then return end

        if vim.bo.filetype == "lua" then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
                end,
            })
        end
    end,
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

vim.api.nvim_create_autocmd("WinResized", {
    group = group,
    pattern = "*",
    callback = function()
        if vim.g.resize then
            vim.cmd(":wincmd =")
        end
    end
})

vim.api.nvim_create_autocmd("TermLeave", {
    group = group,
    callback = function()
        vim.opt_local.relativenumber = true
        vim.opt_local.number = true
    end
})

vim.api.nvim_create_autocmd("TermEnter", {
    group = group,
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
    end
})
