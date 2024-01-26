-- Helper functions to map keys in different modes
local function normal_mode(keymap, action)
    vim.keymap.set("n", keymap, action)
end

local function visual_mode(keymap, action)
    vim.keymap.set("v", keymap, action)
end

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
normal_mode("<leader>y", '"+y')
normal_mode("<leader>Y", '"+y$')
normal_mode("<leader>d", '"_d')
normal_mode("<leader>x", '"_x')
normal_mode("<leader>p", '"_dP')
normal_mode("<leader>y", '"+y')
normal_mode("<leader>Y", '"+Y')

-- Help save time by typing if err things in golang
normal_mode("<leader>ee", "oif err != nil {<CR>}<CR><esc>kkI<esc>")

-- Terminal stuff
normal_mode("<leader>ts", function()
  vim.cmd("12split")
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
