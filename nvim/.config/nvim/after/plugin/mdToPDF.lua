local function PDF()
  local filePath = vim.api.nvim_buf_get_name(0)
  vim.fn.system(string.format("~/.local/bin/markdown-to-pdf %s", filePath))
end

vim.api.nvim_create_user_command("PDF", PDF, { nargs='?' })
