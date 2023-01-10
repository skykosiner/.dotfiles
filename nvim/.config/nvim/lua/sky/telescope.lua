local actions = require('telescope.actions')
local themes = require('telescope.themes')

require('telescope').setup {
    defaults = themes.get_dropdown({
        winbled = 10,
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' > ',
        color_devicons = true,
        respect_gitignore = true,
        sorting_strategy = "descending",
        prompt_position = "top",
        scroll_strategy = "cycle",

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-s>"] = actions.select_horizontal,
            },
        }
    }),
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
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
        lsp_references = { path_display = { "shorten" } },
        lsp_document_symbols = { path_display = { "hidden" } },
        lsp_workspace_symbols = { path_display = { "shorten" } },
    },
}

require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("fzf")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("todo_me_daddy")

local M = {}

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< .dotfiles >",
        cwd = "/home/yoni/.dotfiles",
        hidden = true,
    })
end

local function set_background(content)
    vim.fn.system(
        string.format("change_background %s", content)
    )
end

local function select_background(prompt_bufnr, map)
    local function set_the_background(close)
        local content = require("telescope.actions.state").get_selected_entry(
            prompt_bufnr
        )
        set_background(content.cwd .. "/" .. content.value)
        if close then
            require("telescope.actions").close(prompt_bufnr)
        end
    end

    map("i", "<C-s>", function()
        set_the_background(false)
    end)

    map("i", "<CR>", function()
        set_the_background(true)
    end)
end

local function image_selector(prompt, cwd)
    return function()
        require("telescope.builtin").find_files({
            previewer = false,
            prompt_title = prompt,
            cwd = cwd,

            layout_config = {
                width = 0.5,
                height = 0.9,
            },

            attach_mappings = function(prompt_bufnr, map)
                select_background(prompt_bufnr, map)

                -- Please continue mapping (attaching additional key maps):
                -- Ctrl+n/p to move up and down the list.
                return true
            end,
        })
    end
end

M.anime_selector = image_selector("< Change background> ", "~/.dotfiles/anime")

-- Remaps
vim.keymap.set("n", "<leader>pf", "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>")
vim.keymap.set("n", "<C-p>", ":lua require('telescope.builtin').git_files()<CR>")
vim.keymap.set("n", "<leader>ps",
    ":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>")
vim.keymap.set("n", "<leader>pb", ":lua require('telescope.builtin').buffers()<CR>")
vim.keymap.set("n", "<leader>lps", ":lua require('telescope.builtin').lsp_references()<CR>")
vim.keymap.set("n", "<leader>ld", ":Telescope diagnostics<cr>")
vim.keymap.set("n", "<leader>vrc", ":lua require('sky.telescope').search_dotfiles()<CR>")
vim.keymap.set("n", "<leader>pw",
    ":lua require('telescope.builtin').grep_string { search = vim.fn.expand('<cword>') }<CR>")
vim.keymap.set("n", "<leader>vih", ":lua require('telescope.builtin').help_tags()<CR>")
vim.keymap.set("n", "<leader>va", ":lua require('sky.telescope').anime_selector()<CR>")
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>")
vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>")
vim.keymap.set("n", "<leader>gw",
    ":lua require('telescope').extensions.git_worktree.git_worktrees({ layout_config = { width = 0.5, height = 0.5 }})<CR>")
vim.keymap.set("n", "<leader>gm",
    ":lua require('telescope').extensions.git_worktree.create_git_worktree({ layout_config = { width = 0.5, height = 0.5 }})<CR>")
vim.keymap.set("n", "<leader>sc", ":lua require('sky.utils').set_color()<CR>")
vim.keymap.set('n', '<leader>or', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })

return M
