return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim"
    },
    config = function()
      local actions = require('telescope.actions')
      local themes = require('telescope.themes')

      require('telescope').setup {
        defaults = themes.get_ivy {
          winbled           = 10,
          file_sorter       = require('telescope.sorters').get_fzy_sorter,
          prompt_prefix     = "> ",
          color_devicons    = true,
          respect_gitignore = true,
          sorting_strategy  = "descending",
          prompt_position   = "top",
          scroll_strategy   = "cycle",
          file_previewer    = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer    = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer  = require('telescope.previewers').vim_buffer_qflist.new,
          mappings          = {
            i = {
              ["<C-x>"] = false,
              ["<C-q>"] = actions.send_to_qflist,
              ["<C-s>"] = actions.select_horizontal,
            },
          }
        },
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          },
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        },

        pickers = {
          git_branches = {
            mappings = {
              i = {
                ["<C-a>"] = false
              }
            }
          },
          buffers = {
            sort_mru = true,
            mappings = {
              i = { ["<c-d>"] = actions.delete_buffer },
            },
          },
        },
      }

      require("telescope").load_extension("git_worktree")
      require("telescope").load_extension("fzy_native")
      require("telescope").load_extension("harpoon")

      vim.keymap.set("n", "<leader>pf", ":lua require('telescope.builtin').find_files({ hidden = true })<CR>")
      vim.keymap.set("n", "<C-p>", ":lua require('telescope.builtin').git_files()<CR>")
      vim.keymap.set("n", "<leader>ps",
        ":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>")
      vim.keymap.set("n", "<leader>pp", ":lua require('telescope.builtin').live_grep()<CR>")
      vim.keymap.set("n", "<leader>pb", ":lua require('telescope.builtin').buffers()<CR>")

      vim.keymap.set("n", "<leader>vih", ":Telescope help_tags<CR>")

      -- Grep the current highlighted selction
      vim.keymap.set("v", "<leader>ps",
        "\"gy<cmd>lua require(\"telescope.builtin\").grep_string({ search = vim.fn.getreg(\"g\") })<cr>")

      vim.keymap.set("n", "<leader>vrc", function()
        require("telescope.builtin").find_files({
          prompt_title = ".dotfiles",
          cwd = os.getenv("HOME") .. "/.dotfiles",
          hidden = true,
        })
      end)

      vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>")
      vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>")
    end,
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require("git-worktree").setup {}
      vim.keymap.set("n", "<leader>gw",
        ":lua require('telescope').extensions.git_worktree.git_worktrees({ layout_config = { width = 0.5, height = 0.5 }})<CR>")
      vim.keymap.set("n", "<leader>gm",
        ":lua require('telescope').extensions.git_worktree.create_git_worktree({ layout_config = { width = 0.5, height = 0.5 }})<CR>")
    end,
  },
}
