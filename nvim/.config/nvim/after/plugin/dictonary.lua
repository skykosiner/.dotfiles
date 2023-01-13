function CreateWordSearch(word)
  local width = 90
  local height = 20

  word = string.gsub(word, "\n", "")

  local output = vim.fn.systemlist("echo " .. word .. "| ~/.local/bin/dictonary")
  local buf = vim.api.nvim_create_buf(false, true)

  local lines = 0
  for _, value in pairs(output) do
    vim.api.nvim_buf_set_lines(buf, lines, -1, true, { value })
    lines = lines + 1
  end

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = (vim.api.nvim_get_option("lines") - height) / 2,
    col = (vim.api.nvim_get_option("columns") - width) / 2,
  }

  vim.api.nvim_open_win(buf, true, opts)
end

vim.keymap.set("n", "<leader>dd", function()
  local currentWord = vim.fn.expand('<cword>')

  CreateWordSearch(currentWord)
end)

vim.keymap.set("v", "<leader>dd",
  "\"dy<cmd>lua CreateWordSearch(vim.fn.getreg(\"d\"))<cr>")
