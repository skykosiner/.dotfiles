"lua require("yoni")

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
"nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>

nnoremap <leader>vrc :lua require('yoni.telescope').search_dotfiles()<CR>
nnoremap <leader>ps :lua require('yoni.telescope').grep()<CR>

nnoremap <leader>va :lua require('yoni.telescope').anime_selector()<CR>


nnoremap <leader>gb :Telescope git_branches<CR>
nnoremap <leader>gc :Telescope git_commits<CR>
nnoremap <leader>gs :Telescope git_status<CR>

nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
