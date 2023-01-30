--[[ local group = vim.api.nvim_create_augroup("TERMSTUFF", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", { callback = function()
  print("test???")
  if vim.bo.filetype == "term" then
    vim.opt_local.relativenumber = true
    vim.opt_local.number = true
  end
end, group = group })

vim.api.nvim_create_autocmd("InsertEnter", { callback = function()
  print("test???")
  if vim.bo.filetype == "term" then
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end
end, group = group }) ]]

vim.opt_local.relativenumber = false
vim.opt_local.number = false
vim.opt_local.scrolloff = 0
