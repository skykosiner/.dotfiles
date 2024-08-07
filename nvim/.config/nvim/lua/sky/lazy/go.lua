return {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("go").setup({
            lsp_inlay_hints = {
                enable = true,
                style = 'inlay',
                only_current_line = false,
                only_current_line_autocmd = "CursorHold",
                show_variable_name = true,
                parameter_hints_prefix = "󰊕 ",
                show_parameter_hints = true,
                other_hints_prefix = "=> ",
                max_len_align = false,
                max_len_align_padding = 1,
                right_align = false,
                right_align_padding = 6,
                highlight = "Comment",
            },
        })

        local function tag(prompt_bufnr)
            local content = require("telescope.actions.state").get_selected_entry(
                prompt_bufnr
            )

            require("telescope.actions").close(prompt_bufnr)

            vim.cmd(":GoAddTag " .. content.value)
        end

        vim.keymap.set("n", "<leader>ta", function()
            local opts = require("telescope.themes").get_cursor {}
            require("telescope.pickers").new(opts, {
                prompt_title = "Tags",
                finder = require("telescope.finders").new_table({
                    results = {
                        "json",
                        "sql",
                    }
                }),
                sorter = require("telescope.config").values.generic_sorter({}),
                attach_mappings = function(_, map)
                    map("i", "<CR>", tag)
                    return true
                end,
            }):find()
        end)
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
