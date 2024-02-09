return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs"
        }
      })
    end
  }
}
