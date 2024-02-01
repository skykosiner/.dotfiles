return {
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      "hrsh7th/cmp-path",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind-nvim",
      "simrat39/symbols-outline.nvim"
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "<leader>do", function() require("trouble").toggle() end)
      vim.keymap.set("n", "[d", function() require("trouble").next({ skip_groups = true, jump = true }) end)
      vim.keymap.set("n", "]d", function() require("trouble").previous({ skip_groups = true, jump = true }) end)
    end
  }
}
