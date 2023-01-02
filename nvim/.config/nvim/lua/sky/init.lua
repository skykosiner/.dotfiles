-- Local vim porjects
vim.opt.rtp:append(vim.fn.expand "~/personal/todo-me-daddy/fix-everything")
vim.opt.rtp:append(vim.fn.expand "~/personal/twitch-bot/ui")
vim.opt.rtp:append(vim.fn.expand "~/personal/harpoon/auto-group")
vim.opt.rtp:append(vim.fn.expand "~/personal/duckytype.nvim")
vim.opt.rtp:append(vim.fn.expand "~/personal/statusline.nvim/")

require("sky.sets")
require("sky.keymaps")
require("sky.telescope")
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
