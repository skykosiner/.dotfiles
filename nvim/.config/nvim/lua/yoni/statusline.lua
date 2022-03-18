local M = {}

local write_count = 0
local git_branch = "git"

M.get_file_name = function()
    local name = vim.api.nvim_buf_get_name(0)

    if not name or name == "" then
        return "(no name)"
    end

    local new_name = name:gsub("^/home/yoni/", "")

    return new_name
end

M.get_git_branch = function()
    git_branch = vim.fn["fugitive#head"]()

    if not git_branch or git_branch == "" then
        git_branch = "(no git)"
    end

    git_branch = " " .. git_branch

    return git_branch
end

M.get_line_info = function()
    local line = vim.fn.line(".")
    local offset = vim.fn.col(".")

    return string.format("%d:%d", line, offset)
end

M.get_mode = function()
    -- Get the current mode
    local mode = vim.fn.mode()

    local mode_table = {
        ["n"] = "normal",
        ["i"] = "insert",
        ["v"] = "visual",
        ["s"] = "select",
        ["S"] = "select",
        ["R"] = "replace",
        ["Rv"] = "replace",
        ["c"] = "command",
        ["cv"] = "command",
        ["t"] = "terminal",
        ["V"] = "visual",
        ["g"] = "goto",
        ["r"] = "replace",
    }

    if mode_table[mode] then
        mode = mode_table[mode]
    end

    return mode
end

M.get_filetype = function()
  local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
  local filetype = vim.bo.filetype

  if filetype == '' then return '' end
  return string.format(' %s %s ', icon, filetype):lower()
end

M.on_write = function()
    write_count = write_count + 1
end

M.get_write_count = function()
    return write_count
end

-- local statusline = "%s%%-15.23(%s%%)|%%-14.14(%s%%) %s %s %s %s"
local statusline = "%s%%  | %s%%) | %%-5.1000(%s%%) | %%-1.1(%s%%) |%%-5.9(%s%%)%%-6.6 | %s%%)"

M.StatusLine = function()
    return string.format(statusline,
    M.get_mode(),
    M.get_git_branch(),
    M.get_file_name(),
    M.get_write_count(),
    M.get_filetype(),
    M.get_line_info(),
    status_line)
end

vim.o.statusline = '%!v:lua.require("yoni.statusline").StatusLine()'

vim.api.nvim_exec([[
augroup YONI_STATUSLINE
    autocmd!
    autocmd BufWritePre * :lua require("yoni.statusline").on_write()
augroup END
 ]], false)

return M
