local opt = vim.opt
local g = vim.g

g.mapleader = " "

-- Keep cursor a block in insert mode
opt.guicursor = ""

-- Don't have so many statuslines per window
opt.laststatus = 3

-- Line numbers as they help you jupm around code fast
opt.number = true
opt.relativenumber = true

-- Make colors look nice and so on
opt.termguicolors = true

-- Allow plugins like undotree to work well
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.swapfile = false
opt.backup = false

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

-- Sign coulumn on to make lsp linting better
opt.signcolumn = "yes"

-- Start to scroll 8 lines before the bottom/top
opt.scrolloff = 8

-- If nothing is typed for 50ms then the swap file for the current file will be writen to the list
opt.updatetime = 50

-- Keep buffers in memory (uses a bit more ram, but coming from vs code vim is still super light weight even with this being on)
opt.hidden = true

-- Always splitt horizontal below by default
opt.splitbelow = true

-- Help keep track of where cursor is
opt.cursorline = true

opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query

opt.belloff = "all" -- WHO THE FUCK HAS THIS OPTION ON???

opt.breakindent = true
opt.linebreak = true

-- Stop highlighting search results after you leave the search
opt.hlsearch = false

-- Update the title of the window depending on what's currently going on
opt.title = true

-- Make netrtw look nicer
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
g.netrw_localrmdir = 'rm -rf'

-- Help keep track of 80 charcter column limit
opt.colorcolumn = "80"
