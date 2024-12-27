---@param command string
local function create_buffer(command)
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = vim.fn.systemlist(command)

    if #lines > 0 then
        vim.cmd("belowright 12split")
        vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
        vim.api.nvim_win_set_buf(0, buf)
    end
end

vim.keymap.set("n", "<leader>cc", function()
    create_buffer(vim.fn.input("Command > "))
end)
