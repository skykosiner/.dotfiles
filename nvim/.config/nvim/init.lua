require("sky")

-- Just playing around with some stuff json stuff in vim
--[[ function Test()
  local testJSON = '{"test": 123}'
  local testTable = {
    ["test"] = 123
  }

  print(vim.inspect(vim.fn.json_decode(testJSON)))
  print(vim.fn.json_encode(testTable))
end

vim.keymap.set("n", "<leader>te", function()
  Test()
end) ]]
