vim.api.nvim_create_user_command("GoTest", function(opts)
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = vim.fn.systemlist("go test -v ./...")

    if #lines > 0 then
        if opts.args == "vert" then
            vim.cmd("vertical split")
        else
            vim.cmd("belowright 12split")
        end
        vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
        vim.api.nvim_win_set_buf(0, buf)
        vim.opt_local.spell = false
    end
end, {
    nargs = "?",
    desc = "Run a go test in a new buffer horizontally. Use 'vert' to open the buffer vertically.",
    complete = function(_, _)
        return { "vert", "hor" }
    end
})
