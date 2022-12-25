-- Don't know if I like this option or not as it makes my vim look less clean but it's also kind of helpful hmmm
local M = {}

local msg = ""

M.set_status = function(line)
    msg = line
end

local winbar = "%s%s%s%s"

M.Winbar = function()
    return string.format(winbar,
        msg,
        "%=",
        "%m ",
        "%f")
end

vim.opt.winbar = '%!v:lua.require("sky.winbar").Winbar()'

return M
