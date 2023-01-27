require("sky")

-- Just playing around with some stuff json stuff in vim
--[[ function Test()
  local testTable = {
    ["test"] = 123
  }

  local encodedJson = vim.fn.json_encode(testTable)
  print(encodedJson)
  vim.pretty_print(vim.fn.json_decode(encodedJson))
end

vim.keymap.set("n", "<leader>te", function()
  Test()
end) ]]
