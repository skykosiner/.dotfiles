vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  -- Local plugins
  use "~/personal/todo-me-daddy/master/"
  use "~/personal/twitch-bot/ui/"
  use "~/personal/statusline.nvim/"
  use "~/personal/telescope.nvim/"
  use "~/personal/wiki.nvim/"

  use "rcarriga/nvim-notify"

  use {
    "brunoos/luasocket",
    rocks = "luasocket"
  }

  -- NEOVIM IN THE BROWESER
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }


  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use "folke/zen-mode.nvim"
  use "mkitt/tabline.vim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- ASYNC AWAIT ME DADDY
  use { "ms-jpq/lua-async-await", branch = "neo" }

  -- Lsp
  -- use "ray-x/lsp_signature.nvim"
  use "j-hui/fidget.nvim"
  use "simrat39/inlay-hints.nvim"

  use "folke/neodev.nvim"

  use {
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },

      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    }
  }

  use({
    "rose-pine/neovim",
    as = "rose-pine",
  })

  use "norcalli/nvim-colorizer.lua"
  use "tjdevries/gruvbuddy.nvim"
  use "tomasiser/vim-code-dark"
  use "ray-x/go.nvim"
  use "ThePrimeagen/jvim.nvim"
  use "ellisonleao/glow.nvim"
  use "sbdchd/neoformat"
  use "tjdevries/colorbuddy.nvim"
  use "onsails/lspkind-nvim"
  use "projekt0n/github-nvim-theme"
  use "kyazdani42/nvim-web-devicons"
  use "akinsho/bufferline.nvim"
  use "nvim-lua/lsp_extensions.nvim"
  use "rust-lang/rust.vim"
  use "simrat39/rust-tools.nvim"
  use "ThePrimeagen/refactoring.nvim"
  use "mfussenegger/nvim-Dap"
  use "mfussenegger/nvim-jdtls"
  use "L3MON4D3/LuaSnip"
  use "nvim-lua/plenary.nvim"
  use "nvim-treesitter/playground"
  use "nvim-treesitter/nvim-treesitter-context"
  use "tpope/vim-fugitive"
  use "TimUntersberger/neogit"
  use "ThePrimeagen/git-worktree.nvim"
  use "neovim/nvim-lspconfig"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lua"
  use "simrat39/symbols-outline.nvim"
  use "numToStr/Comment.nvim"
  use "gruvbox-community/gruvbox"
  use "ayu-theme/ayu-vim"
  use "dunstontc/vim-vscode-theme"
  use "w0ng/vim-hybrid"
  use "chriskempson/base16-vim"
  use "nvim-lua/popup.nvim"
  -- use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"
  use "mhinz/vim-rfc"
  use "mbbill/undotree"
  use "ThePrimeagen/harpoon"
  use "rafamadriz/friendly-snippets"

  use {
    "folke/tokyonight.nvim", branch = "main"
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }


  -- Org
  -- use {'nvim-orgmode/orgmode', config = function()
    -- require('orgmode').setup{}
  -- end
-- }
end)
