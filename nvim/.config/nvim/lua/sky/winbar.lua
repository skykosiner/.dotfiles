local M = {}

local winbar = "%s"

local function get_name()
    local name = vim.api.nvim_buf_get_name(0)

    if not name or name == "" then
        return "[No Name]"
    end

    local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
    file_name = vim.fn.pathshorten(vim.fn.fnamemodify(name, ":."))

    local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })

    return icon .. " " .. file_name
end

M.winbar = function()
    return string.format(winbar,
        get_name()
    )
end

vim.opt.winbar = '%!v:lua.require("sky.winbar").winbar()'

return M
