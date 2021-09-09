call plug#begin('~/.vim/pluged')
"vim in browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

Plug 'ThePrimeagen/git-worktree.nvim'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'skanehira/preview-markdown.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

"Icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

"Git
Plug 'tpope/vim-fugitive'
Plug 'ThePrimeagen/git-worktree.nvim'

"Lsp pulgins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdcommenter'

"Themes
Plug 'gruvbox-community/gruvbox'
Plug 'ayu-theme/ayu-vim'

"fuzy finder"
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'mhinz/vim-rfc'
Plug 'mbbill/undotree'
Plug 'ThePrimeagen/harpoon'
call plug#end()

lua require("yoni")

"lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

let mapleader = " "
let NERDTreeShowHidden=1

"lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

nnoremap <silent> <C-f> :lua require("harpoon.term").sendCommand(1, "~/scripts/bg -a\n"); require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <silent> <C-q> :lua require("harpoon.term").sendCommand(1, "~/scripts/bg -v\n"); require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <silent> <leader> f :lua require("harpoon.term").sendCommand(1, "~/scripts/tmux2\n"); require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <silent> <leader> bk :lua require("harpoon.term").sendCommand(1, "setxkbmap -layout real-prog-dvorak\n"); require("harpoon.term").gotoTerminal(1)<CR>

"For when reading docs turn of numbers
fun! ReadingDocs()
    :set norelativenumber
    :set nonumber
endfun

nnoremap <leader>rrd :call ReadingDocs()<CR>

vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

nnoremap <leader>fl :Ex<CR>

nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>pv :NERDTreeToggle<CR> :wincmd l<CR> :wq<CR>
nnoremap <leader>ft :NERDTreeToggle<CR> :vertical resize 30<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>


noremap <Leader>t+ :top resize +5<CR>
nnoremap <Leader>t- :top resize -5<CR>

"Coppy selcetd line to clipboard on mac os
vmap <leader>vc :w !pbcopy<CR>

"Coppy file on mac os
nnoremap <leader>pc :%w !pbcopy<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Greatest remap ever
vnoremap <leader>p "_dP

"Next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

vnoremap <leader>d "_d
noremap <leader>d "_d

nnoremap Y y$
nnoremap n nzzzv
nnoremap N nzzzv
nnoremap J mzJ`z

nnoremap * *zzzv
nnoremap # #zzzv
nnoremap , ,zzzv
nnoremap ; ;zzzv

nnoremap <C-\> :cnext<CR>
nnoremap <C-l> :cprev<CR>
nnoremap <C-v> :lnext<CR>
nnoremap <C-z> :lprevious<CR>
nnoremap <leader>po :copen<CR>
nnoremap <leader>lo :lopen<CR>

"Stop annoying visual mode
nnoremap <silent>Q <Nop>

" Use control-c instead of escape
nnoremap <C-c> <Esc>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

noremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

augroup YONI
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
   autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
