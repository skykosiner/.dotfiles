return {
    "tjdevries/colorbuddy.nvim",
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
            })
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                styles = {
                    bold = true,
                    italic = true,
                    transparency = true,
                },
            })
        end
    },
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_contrast = "hard"
            vim.g.gruvbox_material_transparent_background = 2
            vim.g.gruvbox_material_better_performance = 1
        end
    },
    {
        "Shatur/neovim-ayu",
        config = function()
            require("ayu").setup({
                mirage = true,
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    sidebars = "transparent",
                    floats = "transparent",
                },
            })
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                transparent_mode = true,
                contrast = "hard",
            })
        end
    },
    {
        "NTBBloodbath/doom-one.nvim",
        config = function()
            -- Add color to cursor
            vim.g.doom_one_cursor_coloring = true
            -- Set :terminal colors
            vim.g.doom_one_terminal_colors = true
            -- Enable italic comments
            vim.g.doom_one_italic_comments = true
            -- Enable TS support
            vim.g.doom_one_enable_treesitter = true
            -- Color whole diagnostic text or only underline
            vim.g.doom_one_diagnostics_text_color = true
            -- Enable transparent background
            vim.g.doom_one_transparent_background = true

            -- Pumblend transparency
            vim.g.doom_one_pumblend_enable = true
            vim.g.doom_one_pumblend_transparency = 20

            -- Plugins integration
            vim.g.doom_one_plugin_neorg = true
            vim.g.doom_one_plugin_barbar = false
            vim.g.doom_one_plugin_telescope = false
            vim.g.doom_one_plugin_neogit = true
            vim.g.doom_one_plugin_nvim_tree = true
            vim.g.doom_one_plugin_dashboard = true
            vim.g.doom_one_plugin_startify = true
            vim.g.doom_one_plugin_whichkey = true
            vim.g.doom_one_plugin_indent_blankline = true
            vim.g.doom_one_plugin_vim_illuminate = true
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                }
            })
        end
    }
}
