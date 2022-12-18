-- Make sure my leader is set befdore anything happens
vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Local vim porjects
vim.opt.rtp:append(vim.fn.expand "~/personal/todo-me-daddy/fix-shit-coide/")
vim.opt.rtp:append(vim.fn.expand "~/personal/twitch-bot/ui")
vim.opt.rtp:append(vim.fn.expand "~/personal/harpoon/auto-group")
vim.opt.rtp:append(vim.fn.expand "~/personal/duckytype.nvim")

require("sky.plugins")

-- vim.notify = require("notify")

require("sky.globals")
require("sky.autocmd")
require("sky.disable_builtin")
require("sky.telescope")
require("sky.lsp")
require("sky.treesitter")
require("sky.git-worktree")
require("sky.comment")
require("sky.utils")
require("sky.todo-me-daddy")
require("sky.sets")
require("sky.colors")
require("sky.keymaps")
require("sky.refactoring")
require("sky.luasnip")
require("sky.harpoon")
require("sky.statusline")
require("sky.winbar")

require("go").setup()

require("duckytype").setup {
    number_of_words = 69,
    average_word_length = 5.69,
}
