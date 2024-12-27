function SearchWordDict(word)
    word = string.gsub(word, "\n", "")
    local width = 90
    local height = 20
    local output = vim.fn.systemlist("echo " .. word .. "| ~/.local/bin/dictonary")
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = 0
    local lineNum = 1

    for _, line in pairs(output) do
        line = lineNum .. ". " .. line
        vim.api.nvim_buf_set_lines(buf, lines, -1, true, { line })
        lines = lines + 1
        lineNum = lineNum + 1
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
    SearchWordDict(vim.fn.expand('<cword>'))
end)

vim.keymap.set("v", "<leader>dd", "\"dy<cmd>lua SearchWord(vim.fn.getreg(\"d\"))<cr>")
