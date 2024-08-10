local opt = vim.opt

opt.inccommand = "split"

opt.number = true
opt.relativenumber = true

-- Some sane defaults
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.cindent = true
opt.wrap = false

-- Highlight the current search as seacrhing
opt.incsearch = true
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true  -- ... unless there is a capital letter in the query

opt.signcolumn = "yes"

-- Start to scroll 8 lines before the bottom/top
opt.scrolloff = 8

opt.shell = "/bin/zsh"
