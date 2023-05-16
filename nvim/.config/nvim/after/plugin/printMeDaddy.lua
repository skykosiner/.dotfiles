local function Print()
  local filePath = vim.api.nvim_buf_get_name(0)
  vim.fn.system(string.format("lp %s", filePath))
end

vim.api.nvim_create_user_command("Ha", Print, { nargs='?' })
