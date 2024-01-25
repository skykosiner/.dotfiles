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
-- vim.opt.cursorline = true

vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.wrap = false

vim.opt.belloff = "all" -- WHO THE FUCK HAS THIS OPTION ON???

vim.opt.swapfile = false
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

vim.opt.showmode = false

-- vim.opt.list = true
-- Not sure if I like this or not hmmm
-- vim.opt.listchars = "tab:· ,nbsp:_,trail: ,multispace:· ,eol:↲"
-- vim.opt.listchars = { eol = "↲", tab = ">", space = ">" }

-- vim.opt.listchars = {
  -- eol = ' ',
  -- tab = ' ',
  -- multispace = ' ',
  -- tab = '  ',
  -- multispace = '  ',
-- }

vim.opt.title = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_localrmdir = 'rm -rf'

vim.g.python3_host_skip_check = 1
vim.g.python3_host_prog = '/bin/python3'
vim.opt.colorcolumn = "80"

vim.opt_local.conceallevel = 1
