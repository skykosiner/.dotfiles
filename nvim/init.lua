if vim.fn.has("mac") == 1 then
    vim.fn.serverstart("/tmp/nvim." .. vim.loop.os_getpid() .. ".sock")
end

vim.filetype.add {
    extension = {
        templ = "templ",
        mdx = "markdown",
    },
}

vim.g.mapleader = " "
vim.g.resize = true
require "sky.sets"
require "sky.keymaps"
-- require("sky.winbar")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

require("lazy").setup({
    import = "sky/lazy"
}, {
    lockfile = os.getenv("HOME") .. "/.dotfiles/nvim/.config/nvim/lazy-lock.json", -- lockfile generated after running update.
    change_detection = {
        notify = false,
    },
})

vim.api.nvim_create_user_command("Scratch", function()
    vim.cmd "bel 10new"
    local buf = vim.api.nvim_get_current_buf()
    for name, value in pairs {
        filetype = "scratch",
        buftype = "nofile",
        bufhidden = "wipe",
        swapfile = false,
        modifiable = true,
    } do
        vim.api.nvim_set_option_value(name, value, { buf = buf })
    end
end, { desc = "Open a scratch buffer", nargs = 0 })
