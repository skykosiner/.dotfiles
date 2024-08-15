local M = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local utils = require('telescope.previewers.utils')
local previewers = require('telescope.previewers')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local Job = require("plenary.job")

---@param name string
---@return string[]
local function get_logs(name)
    local j = Job:new({
        command = "docker",
        args = { "logs", name },
    })

    local ok, res = pcall(function()
        return j:sync()
    end)

    if not ok then
        return { "" }
    end

    return res
end

function M.docker_logs(opts)
    pickers.new(opts, {
        finder = finders.new_async_job({
            command_generator = function()
                return { "docker", "ps", "-a", "--format", "{{.Names}}" }
            end,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry,
                    ordinal = entry
                }
            end
        }),
        sorter = config.generic_sorter(opts),
        previewer = previewers.new_buffer_previewer({
            title = "Docker Logs",
            define_preview = function(self, entry)
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, get_logs(entry.value))
                utils.highlighter(self.state.bufnr, "markdown")
            end,
        }),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry().value
                actions.close(prompt_bufnr)

                local command = {
                    "tabnew",
                    "term://docker",
                    "logs",
                    selection
                }

                vim.cmd(vim.fn.join(command, " "))
            end)
            return true
        end,

    }):find()
end

vim.keymap.set("n", "<leader>dl", M.docker_logs)

return M
