vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Sweet resizes baby
vim.keymap.set("n", "<leader>+", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<leader>-", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<leader>t+", "<cmd>top resize +5<CR>")
vim.keymap.set("n", "<leader>t-", "<cmd>top resize -5<CR>")

vim.keymap.set("n", "<C-j>", ":cnext<CR>")
vim.keymap.set("n", "<C-k>", ":cprev<CR>")
vim.keymap.set("n", "<leader>j", ":lnext<CR>")
vim.keymap.set("n", "<leader>k", ":lprevious<CR>")
vim.keymap.set("n", "<leader>po", ":copen<CR>")
vim.keymap.set("n", "<leader>lo", ":lopen<CR>")

vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "#", "#zzzv")
vim.keymap.set("n", ",", ",zzzv")
vim.keymap.set("n", ";", ";zzzv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>o", "o<Esc>^Da")
vim.keymap.set("n", "<leader>O", "O<Esc>^Da")

-- Use control-c instead of esc, please don't fire me
vim.keymap.set("n", "<C-c>", "<Esc>")

-- Sweet remaps to tab stuff gurlll
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Spelling
vim.keymap.set("n", "<leader>sp", ":lua require('sky.utils').toggleSpell()<CR>")

vim.keymap.set("n", "<leader>ch", "<cmd>!chmod +x %<CR>")

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>x", '"_x')
vim.keymap.set("v", "<leader>p", '"_dP')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>Y", '"+Y')

vim.keymap.set("n", "<silent>Q", "<Nop>")

vim.keymap.set("n", "<leader>r", ":lua require('sky.utils').reload_module()<CR>")

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<CR><esc>kkI<esc>")

vim.keymap.set("n", "<leader><C-o>", ":lua require('sky.utils').open_dir_nnn()<CR>")

vim.keymap.set("n", "<leader>gcc", ":norm ^i{/*<esc>A*/}<esc><CR>")
vim.keymap.set("n", "<leader>guc", ":norm ^df*f*D<CR>")

vim.keymap.set("n", "<leader>o", "o<esc>ko")

vim.keymap.set("n", "<leader>ss", function()
    vim.o.statusline = '%!v:lua.status()'
end)

-- File stuff
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Have some sex on the side baby
vim.keymap.set("n", "<leader>ft", ":Sex!<CR>")

vim.keymap.set("n", "<leader>ea", "[[ <cmd>lua require('twitch-bot').init()<CR> ]]")
vim.keymap.set("n", "<leader>ed", "[[ <cmd>lua require('twitch-bot').disconnect()<CR> ]]")