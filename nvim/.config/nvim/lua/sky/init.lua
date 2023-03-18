-- Thinking about trying out lazy.nvim
--[[ local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath) ]]

require("sky.sets")
require("sky.keymaps")
require("sky.packer")
require("sky.telescope")
-- Don't use any of these two right now
-- require("sky.statusline")
require("sky.winbar")

-- We create a grop which will be cleared each time, this is so we don't have multiple autocommands running (or something like that)
local group = vim.api.nvim_create_augroup("SKY", { clear = true })

-- Give that sweet little thing for a second on a yank, so I know what I have yanked
vim.api.nvim_create_autocmd("TextYankPost", { callback = function()
  vim.highlight.on_yank({ timeout = 50 })
end, group = group })

-- Clear whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", { callback = function()
  -- This is scuffed, but lua won't let me use \ to escapee a Character, and
  -- vim does not like it when you use |
  vim.cmd([[:%s/\s\+$//e]])
end, group = group })

-- For when you use firenvim in the browesr
vim.api.nvim_create_autocmd("UIEnter", { callback = function()
  vim.opt.winbar = ""
  vim.opt.colorcolumn = nil
end, group = group })

-- idk really, make vim.notify shut up lol
require("notify").setup({
  background_colour = "#000000",
})

-- Save as sudo with Sw
vim.cmd([[ command! -nargs=0 Sw w !sudo tee % > /dev/null ]])
