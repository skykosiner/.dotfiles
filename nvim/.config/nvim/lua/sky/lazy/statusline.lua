return {
  {
    -- "skykosiner/statusline.nvim",
    dir = "/home/sky/personal/statusline.nvim/",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("statusLine").setStatus()
    end
  }
}
