-- Helper functions to map keys in different modes

---@param keymap string
---@param action string | function
local function normal_mode(keymap, action)
    vim.keymap.set("n", keymap, action)
end

---@param keymap string
---@param action string | function
local function visual_mode(keymap, action)
    vim.keymap.set("v", keymap, action)
end

normal_mode("<C-f>", ":silent !tmux neww ~/.local/bin/tmux-sessionizer<CR>")

normal_mode("<leader><leader>x", ":so %<CR>")

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

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Terminal stuff
normal_mode("<leader>ts", function()
    vim.cmd("belowright 12split")
    vim.cmd("set winfixheight")
    vim.cmd("term")
    vim.cmd("startinsert")
end)

normal_mode("<leader>tv", function()
    vim.cmd("vsplit")
    vim.cmd("term")
    vim.cmd("startinsert")
end)

normal_mode("<leader>tt", function()
    vim.cmd.tabnew()
    vim.cmd.terminal()
    vim.cmd.startinsert()
    require("harpoon"):list("term"):add()
end)

-- TODO: Finish setting up the floating terminal
--[[normal_mode("<leader>tf", function()
    require("plenary.window.float").percentage_range_window(0.7, 0.7)
    vim.cmd.terminal()
    vim.cmd.startinsert()
end)]] --

normal_mode("<M-,>", "<c-w>5<")
normal_mode("<M-.>", "<c-w>5>")
normal_mode("<M-t>", "<C-W>+")
normal_mode("<M-s>", "<C-W>-")

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

-- Toggle hlsearch if it's on, otherwise just do "enter"
normal_mode("<CR>", function()
    ---@diagnostic disable-next-line: undefined-field
    if vim.v.hlsearch == 1 then
        vim.cmd.nohl()
        return ""
    else
        return vim.keycode "<CR>"
    end
end)

normal_mode("<leader>sp", function()
    ---@diagnostic disable-next-line: undefined-field
    if vim.opt.spell._value then
        vim.opt.spell = false
    else
        vim.opt.spell = true
    end
end)

normal_mode("<space>th", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
end)

vim.keymap.set("i", "<C-c>", "<esc>")
