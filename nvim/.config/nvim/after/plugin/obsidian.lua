require'obsidian'.setup({
  dir = "~/Documents/Linux-btw/",

  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = "Daily",
    -- Optional, if you want to change the date format for daily notes.
    date_format = "%Y-%m-%d"
  },

  templates = {
    subdir = "Templates",
    date_format = "%Y-%m-%d-%a",
    time_format = "%H:%M",
  },

  completion = {
    nvim_cmp = true,  -- if using nvim-cmp, otherwise set to false
  },

  disable_frontmatter = true,

  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return suffix
  end,
})

vim.keymap.set("n", "<leader>l", ":ObsidianFollowLink<CR>")
vim.keymap.set("n", "<leader>r", ":ObsidianBacklinks<CR>")
vim.keymap.set("n", "<leader>sn", ":ObsidianQuickSwitch<CR>")
vim.keymap.set("n", "<leader>sl", ":ObsidianSearch<CR>")
vim.keymap.set("n", "<leader>t", ":ObsidianToday<CR>")
