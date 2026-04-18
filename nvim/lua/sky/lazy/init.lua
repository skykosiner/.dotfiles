return {
    {
        "dhruvasagar/vim-zoom"
    },
    {
        dir = os.getenv("HOME") .. "/personal/rfc.nvim/"
    },
    {
        dir = os.getenv("HOME") .. "/personal/tmux-commands.nvim/",
        config = function()
            local tmux_comamnds = require("tmux_commands")
            tmux_comamnds:setup {
                window_name = "commands",
            }

            vim.keymap.set("n", "<leader>tc", function()
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local config = require("telescope.config").values
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                pickers.new({}, {
                    finder = finders.new_table({
                        "go test -v ./...",
                        "npm run dev",
                        "cargo run"
                    }),
                    sorter = config.generic_sorter({}),
                    attach_mappings = function(prompt_bufnr)
                        actions.select_default:replace(function()
                            actions.close(prompt_bufnr)

                            local selection = action_state.get_selected_entry().value
                            tmux_comamnds:send_command(selection)
                        end)
                        return true
                    end,
                }):find()
            end)
        end
    }
}
