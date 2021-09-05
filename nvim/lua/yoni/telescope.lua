local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' > ',
        color_devicons = true,

        --file_ignoe_patterns = {"dist"}
        --file_ignoe_patterns = {"package-lock.json"}
        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
   }
}

require("telescope").load_extension("git_worktree")
require('telescope').load_extension('fzy_native')

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = " dotfiles ",
        cwd = "/Users/yonikosiner/.dotfiles",
    })
end

M.grep = function()
    require("telescope.builtin").live_grep({
        prompt_title = " Grep "
    })
end


--"osascript -e 'tell application Finder' to set desktop picture to POSIX file content"
--
 --"dconf write /org/mate/desktop/background/picture-filename \"'"
            --.. content
            --.. "'\""

local function set_background(content)
    os.execute(cmd,
        "osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"'"
            .. content
            .. "'\""
    )
end

local function select_background(prompt_bufnr, map)
    local function set_the_background(close)
       local content = require("telescope.actions.state").get_selected_entry(
            prompt_bufnr
        )
        set_background(content)
        if close then
            require("telescope.actions").close(prompt_bufnr)
        end
    end

    map("i", "<C-p>", function()
        set_the_background()
    end)

    map("i", "<CR>", function()
        set_the_background(true)
    end)
end

local function image_selector(prompt, cwd)
    return function()
        require("telescope.builtin").find_files({
            prompt_title = prompt,
            cwd = cwd,

            attach_mappings = function(prompt_bufnr, map)
                select_background(prompt_bufnr, map)

                -- Please continue mapping (attaching additional key maps):
                -- Ctrl+n/p to move up and down the list.
                return true
            end,
        })
    end
end

M.anime_selector = image_selector("< Anime Bobs > ", "~/.dotfiles/anime")

return M
