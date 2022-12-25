require("todo-me-daddy").setup {
    your_name = "Sky",
    get_markdown_todo = true,
    ignore_folders = {
        node_modules = "node_modules",
        public = "public",
    }
}

vim.keymap.set("n", "<leader>td", ":lua require('telescope').extensions.todo_me_daddy.todos()<CR>")
vim.keymap.set("n", "<leader>tg", ":lua require('telescope').extensions.todo_me_daddy.todos_git()<CR>")
vim.keymap.set("n", "<leader>m", ":lua require('todo-me-daddy').completeMarkdownTodo()<CR>")
