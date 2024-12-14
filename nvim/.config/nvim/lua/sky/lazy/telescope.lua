return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

        },
        config = function()
            local actions = require("telescope.actions")
            local themes = require("telescope.themes")

            require("telescope").setup {
                defaults = themes.get_ivy {
                    respect_gitignore = true,
                    mappings          = {
                        i = {
                            ["<C-x>"] = false,
                            ["<C-q>"] = actions.send_to_qflist,
                            ["<C-s>"] = actions.select_horizontal,
                        },
                    }
                },
                extensions = {
                    fzf = {},
                },
            }

            require("telescope").load_extension("git_worktree")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("harpoon")

            local builtin = require "telescope.builtin"

            vim.keymap.set("n", "<leader>pf", function() builtin.find_files({ hidden = true }) end)
            vim.keymap.set("n", "<C-p>", builtin.git_files)
            vim.keymap.set("n", "<leader>pb", builtin.buffers)
            vim.keymap.set("n", "<leader>ps",
                function() builtin.grep_string({ search = vim.fn.input("Grep For > ") }) end)
            vim.keymap.set("n", "<leader>pp", builtin.live_grep)
            vim.keymap.set("n", "<leader>vih", builtin.help_tags)
            vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)

            vim.keymap.set("n", "<space>fa", function()
                ---@diagnostic disable-next-line: param-type-mismatch
                builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
            end)

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
