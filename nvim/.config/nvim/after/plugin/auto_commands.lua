-- Make sure the file type is set to term on terminal open
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd.set "filetype=term"
  end,
})

-- We create a grop which will be cleared each time, this is so we don't have multiple autocommands running (or something like that)
local group = vim.api.nvim_create_augroup("SKY", { clear = true })

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
autocmd BufWritePost ~/.local/src/dwmblocks/blocks.def.h !cd ~/.local/src/dwmblocks/; rm blocks.h; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
]])
