return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup {
      default_file_explorer = false
    }

    vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
