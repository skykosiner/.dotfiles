local Job = require("plenary.job")

local M = {}

local function change_color(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )

    require("telescope.actions").close(prompt_bufnr)

    Colors(content.value)
end

function M.set_color()
    require("telescope.pickers").new({}, {
        prompt_title = "Reload",
        finder = require("telescope.finders").new_table({
            results = {
                "gruvbox",
                "gruvbuddy",
                "ayu",
                "tokyonight",
                "rose-pine"
            }
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", change_color)
            return true
        end,
    }):find()
end

-- Function that intergates with telescope to quickly reload a module
local function reload(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )

    require("telescope.actions").close(prompt_bufnr)

    if content.value == "todo_me_daddy" then
        content.value = "todo-me-daddy"
    elseif content.value == "color-scheme" then
        require("sky.colors").SetColorScheme()
    end

    require('plenary.reload').reload_module(content.value)
end

function M.reload_module()
    require("telescope.pickers").new({}, {
        prompt_title = "Reload",
        finder = require("telescope.finders").new_table({
            results = {
                "todo_me_daddy",
                "harpoon",
                "sky.statusline",
                "color-scheme",
            }
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", reload)
            map("n", "<CR>", reload)
            return true
        end,
    }):find()
end

function M.toggleSpell()
    -- Toggle spelling on or off
    if vim.o.spell == true then
        vim.o.spell = false
    else
        vim.o.spell = true
    end
end

-- Open my current dir in nnn (termianl file manger) with a quick hotkey
function M.open_dir_nnn()
    local currentDir = vim.cmd("pwd")
    Job:new({
        "alacritty",
        "-e",
        "nnn",
        currentDir
    }):start()
end

return M
