return {
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        window = {
          tmux = {
            enabled = false
          },
          kitty = {
            enabled = true,
            font = "+4",
          },
          width = 100,
          options = {
          }
        },
      }

      vim.keymap.set("n", "<leader>zz", function()
        require("zen-mode").toggle()
        -- vim.wo.wrap = false
      end)
    end
  }
}
