-- Stollen from the vim man him self
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

-- Use control-c instead of esc. Yes I vim in style
vim.keymap.set("n", "<C-c>", "<Esc>")

-- Sweet remaps to tab stuff
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Spelling as I suck at it
vim.keymap.set("n", "<leader>sp", ":lua require('sky.utils').toggleSpell()<CR>")

-- CHMOD ME DADDY
vim.keymap.set("n", "<leader>ch", "<cmd>!chmod +x %<CR>")

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>x", '"_x')
vim.keymap.set("v", "<leader>p", '"_dP')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>Y", '"+Y')

vim.keymap.set("n", "<silent>Q", "<Nop>")

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<CR><esc>kkI<esc>")

-- Open the current dir in nnn (a terminal based file manger)
vim.keymap.set("n", "<leader><C-o>", ":lua require('sky.utils').open_dir_nnn()<CR>")

-- Make comments in react, don't realy code in react though, so don't think I need this
-- vim.keymap.set("n", "<leader>gcc", ":norm ^i{/*<esc>A*/}<esc><CR>")
-- vim.keymap.set("n", "<leader>guc", ":norm ^df*f*D<CR>")


-- Set the status line as sometimes it glitechs
vim.keymap.set("n", "<leader>ss", function()
  vim.o.statusline = '%!v:lua.status()'
end)

-- File stuff
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Have some sex on the side baby
vim.keymap.set("n", "<leader>ft", ":Sex!<CR>")

-- TWITCH BOT
vim.keymap.set("n", "<leader>ea", "[[ <cmd>lua require('twitch-bot').init()<CR> ]]")
vim.keymap.set("n", "<leader>ed", "[[ <cmd>lua require('twitch-bot').disconnect()<CR> ]]")

-- Terminal stuff
vim.keymap.set("n", "<leader>ts", function()
  vim.cmd("12split")
  vim.cmd("set winfixheight")
  vim.cmd("term")
  vim.cmd("startinsert")
end)

vim.keymap.set("n", "<leader>tu", function()
  vim.cmd("terminal")
  vim.cmd("startinsert")
end)

vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("tabnew")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end)

vim.keymap.set("n", "<leader>tv", function()
  vim.cmd("vsplit")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end)

-- Grep the current highlighted selction
vim.keymap.set("v", "<leader>ps",
  "\"gy<cmd>lua require(\"telescope.builtin\").grep_string({ search = vim.fn.getreg(\"g\") })<cr>")

-- Tab stuff
vim.keymap.set("n", "<right>", "gt")
vim.keymap.set("n", "<left>", "gT")
vim.keymap.set("n", "<leader>nn", ":tabnew<CR>")

-- MOVE STUFF BABY
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
