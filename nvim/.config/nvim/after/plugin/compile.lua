vim.api.nvim_create_user_command("Python", function()
    print(vim.fn.system("python3 " .. vim.api.nvim_buf_get_name(0)))
end, {})

vim.api.nvim_create_user_command("Rust", function()
    print(vim.fn.system("cargo build --release"))
end, {})
