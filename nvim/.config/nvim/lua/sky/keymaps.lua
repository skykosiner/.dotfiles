-- Helper functions to map keys in different modes
local function normal_mode(keymap, action)
  vim.keymap.set("n", keymap, action)
end

local function visual_mode(keymap, action)
  vim.keymap.set("v", keymap, action)
end

normal_mode("<C-f>", ":silent !tmux neww ~/.local/bin/tmux-sessionizer<CR>")

-- Open file explorer
normal_mode("<leader>pv", vim.cmd.Ex)

-- Quick fix list navigation
normal_mode("<C-j>", ":cnext<CR>")
normal_mode("<C-k>", ":cprev<CR>")
normal_mode("<leader>po", ":copen<CR>")

-- Keep stuff centred while moving around
normal_mode("*", "*zzzv")
normal_mode("#", "#zzzv")
normal_mode(",", ",zzzv")
normal_mode(";", ";zzzv")
normal_mode("n", "nzzzv")
normal_mode("N", "Nzzzv")

-- Some fun register stuff
visual_mode("<leader>y", '"+y')
normal_mode("<leader>Y", '"+y$')
visual_mode("<leader>d", '"_d')
normal_mode("<leader>x", '"_x')
normal_mode("<leader>p", '"_dP')

-- Terminal stuff
normal_mode("<leader>ts", function()
  vim.cmd("belowright 12split")
  vim.cmd("set winfixheight")
  vim.cmd("term")
  vim.cmd("startinsert")
end)

normal_mode("<leader>tu", function()
  vim.cmd("terminal")
  vim.cmd("startinsert")
end)

normal_mode("<leader>tt", function()
  vim.cmd("tabnew")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end)

normal_mode("<leader>tv", function()
  vim.cmd("vsplit")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end)

-- Keep things highlighted after moving with < and >
visual_mode("<", "<gv")
visual_mode(">", ">gv")

-- Move stuff up and down in visual mode
visual_mode("J", ":m '>+1<CR>gv=gv")
visual_mode("K", ":m '<-2<CR>gv=gv")

-- Switch between tabs
normal_mode("<Left>", "gT")
normal_mode("<Right>", "gt")

normal_mode("<leader>co", ":!/home/sky/.local/bin/compiler %<CR>")

-- Open new tumx window in the current directory
normal_mode("<leader>tnw", function()
  local currentDir = vim.uv.cwd()
  vim.cmd("silent !tmux neww -c " .. currentDir)
end)

-- With wrap mode this will move the cursor to the next line
normal_mode("j", "gj")
normal_mode("k", "gk")
