require'obsidian'.setup({
  dir = "~/Documents/Linux-btw/",

  completion = {
    nvim_cmp = true,  -- if using nvim-cmp, otherwise set to false
  },

  disable_frontmatter = true,
})

vim.keymap.set("n", "<leader>l", ":ObsidianFollowLink<CR>")
vim.keymap.set("n", "<leader>r", ":ObsidianBacklinks<CR>")
vim.keymap.set("n", "<leader>sn", ":ObsidianQuickSwitch<CR>")
vim.keymap.set("n", "<leader>sl", ":ObsidianSearch<CR>")
vim.keymap.set("n", "<leader>t", ":ObsidianToday<CR>")
