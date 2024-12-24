local opt = vim.opt

opt.inccommand = "split"
opt.number = true
opt.relativenumber = true

-- opt.conceallevel = 1

-- Some sane defaults
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.cindent = true
opt.wrap = false
opt.linebreak = true

-- Highlight the current search as seacrhing
opt.incsearch = true
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true  -- ... unless there is a capital letter in the query

opt.signcolumn = "no"

-- Start to scroll 8 lines before the bottom/top
opt.scrolloff = 8

vim.opt.colorcolumn = "80"

opt.shell = "/run/current-system/sw/bin/zsh"

-- vim.opt.list = true
-- Not sure if I like this or not hmmm
-- vim.opt.listchars = "tab:· ,nbsp:_,trail: ,multispace:· ,eol:↲"
-- vim.opt.listchars = "tab:· ,nbsp:_,trail: ,multispace:· "
-- vim.opt.listchars = { eol = "↲", tab = ">", space = ">" }

-- vim.opt.listchars = {
--     eol = ' ',
--     tab = ' ',
--     multispace = ' ',
--     tab = '  ',
--     multispace = '  ',
-- }
