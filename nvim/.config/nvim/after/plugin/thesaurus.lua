local curl = require "plenary.curl"
local api_key = os.getenv("THESAURUS_API_KEY")

---@class Word
---@field word string
---@field synonyms string[]
---@field antonyms string[]

---@param word string
---@return string
local function make_request_url(word)
    return string.format("https://api.api-ninjas.com/v1/thesaurus?word=%s", word)
end

---@param word Word
local function capitalize_and_number_lines(word_list, start_line)
    local lines = {}
    for i, line in ipairs(word_list) do
        table.insert(lines, string.format("%d. %s", start_line + i - 1, line:sub(1, 1):upper() .. line:sub(2)))
    end
    return lines
end

---@param word Word
local function create_buffer(word)
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = {}

    if #word.synonyms > 0 then
        table.insert(lines, "# Synonyms")
        vim.list_extend(lines, capitalize_and_number_lines(word.synonyms, 1))
    end

    if #word.antonyms > 1 then
        table.insert(lines, "# Antonyms")
        vim.list_extend(lines, capitalize_and_number_lines(word.antonyms, #word.synonyms + 1))
    end

    if #lines > 0 then
        vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)

        local width, height = 90, 20
        local opts = {
            relative = "editor",
            width = width,
            height = height,
            row = (vim.o.lines - height) / 2,
            col = (vim.o.columns - width) / 2,
        }

        vim.api.nvim_open_win(buf, true, opts)
        vim.opt_local.wrap = true
        vim.opt_local.filetype = "markdown"
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end
end

local function search_word_thesaurus()
    local word = vim.fn.expand("<cword>")
    local res = curl.get(make_request_url(word), {
        headers = { X_Api_Key = api_key }
    })

    local decoded_res = vim.fn.json_decode(res.body)
    if decoded_res then
        create_buffer(decoded_res)
    else
        print("Error: Could not fetch thesaurus data.")
    end
end

vim.keymap.set("n", "<leader>dt", search_word_thesaurus)
