-- We create a grop which will be cleared each time, this is so we don't have multiple autocommands running (or something like that)
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

-- Clear the terminal harpoon list when quiting vim
vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        for _, idx in ipairs { 1, 2 } do
            require("harpoon"):list("term"):remove_at(idx)
        end
    end,
    group = group
})

-- Give that sweet little thing for a second on a yank, so I know what I have yanked
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 50 })
    end,
    group = group
})

-- Clear whitespace on save and format code
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        -- This is scuffed, but lua won't let me use \ to escapee a Character, and
        -- vim does not like it when you use |
        vim.cmd([[:%s/\s\+$//e]])
        vim.lsp.buf.format()
    end,
    group = group
})

-- Stuff on save
vim.cmd([[
autocmd BufWritePost ~/.dotfiles/.bookm !~/.local/bin/bookmarks --lf && ~/.local/bin/bookmarks --shell
autocmd BufWritePost ~/.dotfiles/.bookmfiles !~/.local/bin/bookmarks --shell-files
]])
