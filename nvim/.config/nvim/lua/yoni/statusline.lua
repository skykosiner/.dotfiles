-- local Color, colors, Group, groups, styles = require('colorbuddy').setup()

local M = {}

local write_count = 0
local git_branch = "git"
local msg = nil

M.get_file_name = function()
    local name = vim.api.nvim_buf_get_name(0)

    if not name or name == "" then
        return "(no name)"
    end

    local new_name = name:gsub("^/home/yoni/", "~/")

    return new_name
end

M.get_git_branch = function()
    git_branch = vim.fn["fugitive#head"]()

    if not git_branch or git_branch == "" then
        git_branch = "(no git)"
        return git_branch
    end

    git_branch = "λ " .. git_branch

    return git_branch
end

M.get_line_info = function()
    local line = vim.fn.line(".")
    local offset = vim.fn.col(".")

    return string.format("%d:%d", line, offset)
end

M.get_mode = function()
    local mode = vim.fn.mode()

    local mode_table = {
        ["n"] = "Normal",
        ["i"] = "Insert",
        ["v"] = "Visual",
        ["s"] = "Select",
        ["S"] = "Select",
        ["R"] = "Replace",
        ["Rv"] = "Replace",
        ["c"] = "Command",
        ["cv"] = "Command",
        ["t"] = "Terminal",
        ["V"] = "Visual",
        ["g"] = "Goto",
        ["r"] = "Replace",
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

  if filetype == '' then return "(no filetype)" end
  return string.format(" %s %s ", icon, filetype):lower()
end

M.on_write = function()
    write_count = write_count + 1
end

local statusline = "%s%%  | %s%%) | %%-5.1000(%s%%) | %%-1.10(%d%%) |%%-5.20(%s%%)%%-6.6 | %s%%)"

if msg or not msg == "" then
    statusline = statusline .. "| %s%%)"
end

M.StatusLine = function()
    if msg or not msg == "" then
        return string.format(statusline,
        M.get_mode(),
        M.get_git_branch(),
        M.get_file_name(),
        write_count,
        M.get_filetype(),
        M.get_line_info(),
        msg)
    else
        return string.format(statusline,
        M.get_mode(),
        M.get_git_branch(),
        M.get_file_name(),
        write_count,
        M.get_filetype(),
        M.get_line_info())
    end
end

vim.o.statusline = '%!v:lua.require("yoni.statusline").StatusLine()'

vim.api.nvim_exec([[
augroup YONI_STATUSLINE
    autocmd!
    autocmd BufWritePre * :lua require("yoni.statusline").on_write()
augroup END
 ]], false)

 M.set_status = function(line)
     msg = line
 end

 -- Color.new("background", "#4a5d6b")
 -- Color.new('background',  '#282c34')
 -- Color.new('red',         '#cc6666')
 -- Color.new('green',       '#99cc99')
 -- Color.new('yellow',      '#f0c674')

 -- Group.new("statusline", colors.yellow, colors.background, styles.NONE)

return M
