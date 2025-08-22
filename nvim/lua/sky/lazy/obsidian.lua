return {
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        -- ft = "markdown",
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "Main Vault",
                        path = "~/Documents/Linux-btw/",
                    },
                },
                ui = {
                    enable = false,
                },
                completion = {
                    -- Set to false to disable completion.
                    nvim_cmp = true,
                },
                -- Optional, for templates (see below).
                templates = {
                    subdir = "Misc/Templates",
                },
                -- Optional, customize how names/IDs for new notes are created.
                note_id_func = function(title)
                    local suffix = ""
                    if title ~= nil then
                        -- If title is given, transform it into valid file name.
                        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                    end

                    return suffix
                end,
                daily_notes = {
                    -- Optional, if you keep daily notes in a separate directory.
                    folder = "Daily/2025",
                    -- Optional, if you want to change the date format for the ID of daily notes.
                    date_format = "%Y-%m-%d",
                    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
                    template = "Daily note.md"
                },
            })

            vim.keymap.set("n", "<leader>so", vim.cmd.ObsidianQuickSwitch)
            vim.keymap.set("n", "<leader>on", vim.cmd.ObsidianNew)
            vim.keymap.set("n", "<leader>ob", vim.cmd.ObsidianBacklinks)
            vim.keymap.set("n", "<leader>gd", vim.cmd.ObsidianFollowLink)
            vim.keymap.set("n", "<leader>,ot", vim.cmd.ObsidianTemplate)

            vim.keymap.set("n", "<leader>ot", vim.cmd.ObsidianToday)
            vim.keymap.set("n", "<leader>ott", vim.cmd.ObsidianTomorrow)
            vim.keymap.set("n", "<leader>oy", vim.cmd.ObsidianYesterday)
        end,
    }
}
