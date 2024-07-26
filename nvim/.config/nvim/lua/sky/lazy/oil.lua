return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup {
      keymaps = {
        ["<C-p>"] = false,
      },
    }

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<space>-", require("oil").toggle_float)
  end
}
