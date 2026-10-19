local curl = require "plenary.curl"

---@class Definitions
---@field definition string

---@class Meanings
---@field partOfSpeech string
---@field definitions Definitions[]

---@class DWord
---@field word string
---@field meanings Meanings[]

---@return DWord
local function request()
    local word = vim.fn.expand("<cword>")
    local res = curl.get("https://api.dictionaryapi.dev/api/v2/entries/en/" .. word, {
        timeout = 1000,
        limit_rate = 1000,
    })

    return vim.fn.json_decode(res.body)[1]
end

local function open_window()
    local width = 90
    local height = 20
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = 0
    local lineNum = 1

    local output = request()

    for _, m in ipairs(output.meanings) do
        for _, d in ipairs(m.definitions) do
            local line = lineNum .. ". " .. d.definition
            vim.api.nvim_buf_set_lines(buf, lines, -1, true, { line })
            lines = lines + 1
            lineNum = lineNum + 1
        end
    end

    local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = (vim.api.nvim_get_option("lines") - height) / 2,
        col = (vim.api.nvim_get_option("columns") - width) / 2,
    }

    vim.api.nvim_open_win(buf, true, opts)
    vim.opt_local.wrap = true
    vim.opt_local.filetype = "markdown"
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
end

vim.keymap.set("n", "<leader>dd", function()
    open_window()
end)
--
-- vim.keymap.set("v", "<leader>dd", "\"dy<cmd>lua SearchWord(vim.fn.getreg(\"d\"))<cr>")
