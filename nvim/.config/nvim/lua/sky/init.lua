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
require("sky.telescope")
require("sky.packer")
-- require("sky.statusline")
-- require("sky.winbar")

-- We create a grop which will be cleared each time, this is so we don't have multiple autocommands running (or something like that)
local group = vim.api.nvim_create_augroup("SKY", { clear = true })

-- Give that sweet little yellow thing for a second on a yank, so I know what I
-- have yanked
vim.api.nvim_create_autocmd("TextYankPost", { callback = function()
  require 'vim.highlight'.on_yank({ timeout = 50 })
end, group = group })

-- Clear whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", { callback = function()
  -- This is scuffed, but lua won't let me use \ to escapee a Character, and
  -- vim does not like it when you use |
  vim.cmd([[:%s/\s\+$//e]])
end, group = group })

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_localrmdir = 'rm -rf'

vim.g.python3_host_skip_check = 1
vim.g.python3_host_prog = '/bin/python3'
