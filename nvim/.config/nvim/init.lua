vim.g.mapleader = " "
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_localrmdir='rm -rf'

local group = vim.api.nvim_create_augroup("YONI", { clear = true })

-- Give that sweet little yellow thing for a second on a yank, so I know what I
-- have yanked
vim.api.nvim_create_autocmd("TextYankPost", { callback = function()
    require'vim.highlight'.on_yank({ timeout = 25 })
end, group = group})

-- Clear whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", { callback = function()
    -- This is scuffed, but lua won't let me use \ to escapee a Character, and
    -- vim does not like it when you use |
    vim.cmd([[:%s/\s\+$//e]])
end, group = group})

-- I can't find out how to do this with lua, so yeah it's like this for now
vim.cmd([[
let &runtimepath.=',' . expand("$HOME") . '/personal/twitch-bot/ui'
let &runtimepath.=',' . expand("$HOME") . '/personal/todo-me-daddy/clean-me-daddy'
let &runtimepath.=',' . expand("$HOME") . '/personal/harpoon'
]])

require("yoni.plugins")
require("yoni.telescope")
require("yoni.lsp")
require("yoni.treesitter")
require("yoni.git-worktree")
require("yoni.statusline")
require("yoni.comment")
require("yoni.utils")
require("yoni.todo-me-daddy")
require("yoni.sets")
require("yoni.colors")
require("yoni.keymaps")
require("yoni.refactoring")
require("yoni.firenvim")
