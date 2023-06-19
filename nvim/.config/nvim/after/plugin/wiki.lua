--[[ local notes = require("wiki.notes")
local links = require("wiki.notes.links")

-- Set the path to where my notes will be
require("wiki").setup(string.format("%s/personal/wiki", os.getenv("HOME")))

vim.keymap.set("n", "<leader>l", function()
  links.find_link_file()
end)

vim.keymap.set("n", "<leader>r", function()
  links.find_links()
end)

vim.keymap.set("n", "<leader>sn", function()
  notes.search_notes()
end)

vim.keymap.set("n", "<leader>sw", function()
  notes.search_notes("work")
end)

vim.keymap.set("n", "<leader>mm", function()
  notes.move_note_to_different_dir()
end)
]]
