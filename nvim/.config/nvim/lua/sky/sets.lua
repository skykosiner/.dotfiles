vim.g.mapleader = " "

vim.opt.guicursor = ""

vim.opt.laststatus = 3

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.cmdheight = 1

vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.hidden = true

vim.opt.splitbelow = true
vim.opt.cursorline = true

vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.wrap = false

vim.opt.belloff = "all" -- Just turn the dang bell off

vim.opt.swapfile = false -- Living on the edge
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.wildignore = "__pycache__"
vim.opt.wildignore = "*.pyc"
vim.opt.wildignore = "*_build/*"
vim.opt.wildignore = "**/coverage/*"
vim.opt.wildignore = "**/node_modules/*"
vim.opt.wildignore = "**/.git/*"
vim.opt.wildignore = "**/_dist/*"
vim.opt.wildignore = vim.opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

vim.opt.wildmode = "longest,list,full"
vim.opt.wildmenu = true

vim.opt.breakindent = true
vim.opt.linebreak = true

vim.opt.hlsearch = false
vim.opt.mouse = "nv"

vim.opt.colorcolumn = "80"

vim.opt.showmode = false

vim.opt.list = true
-- Not sure if I like this or not hmmm
vim.opt.listchars = "tab:· ,nbsp:_,trail: ,multispace:· ,eol:↲"
