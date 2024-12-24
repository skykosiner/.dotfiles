-- Switch to alternative go test file

--@returns string
local function get_alt_file()
    if vim.bo.filetype ~= "go" then
        return ""
    end

    local path = vim.api.nvim_buf_get_name(0)

    if path:match("_test%.go$") then
        path = path:gsub("_test%.go$", ".go")
    elseif path:match("%.go$") then
        path = path:gsub("%.go$", "_test.go")
    end

    return path
end

vim.keymap.set("n", "<leader>af", function()
    local alt_file = get_alt_file()
    if alt_file ~= "" then
        vim.cmd(":e " .. get_alt_file())
    end
end)
