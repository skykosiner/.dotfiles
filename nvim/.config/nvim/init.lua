vim.g.mapleader = " "
require("sky.sets")
require("sky.keymaps")
-- require("sky.winbar")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "sky/lazy" }, {
  lockfile = os.getenv("HOME") .. "/.dotfiles/nvim/.config/nvim/lazy-lock.json", -- lockfile generated after running update.
    change_detection = {
        notify = false,
    },
})
