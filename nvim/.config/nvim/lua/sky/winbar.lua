-- Don't know if I like this option or not as it makes my vim look less clean but it's also kind of helpful hmmm
local M = {}

local msg = ""

M.set_status = function(line)
  msg = line
end

local function get_name()
  local name = vim.api.nvim_buf_get_name(0)

  if not name or name == "" then
    return "[No Name]"
  end

  local file_name = vim.fn.expand("%:t")
  file_name = vim.fn.pathshorten(vim.fn.fnamemodify(name, ":."))

  return file_name
end

local winbar = "%s%s%s"

M.Winbar = function()
  return string.format(winbar,
    msg,
    "%=",
    get_name())
end

vim.opt.winbar = '%!v:lua.require("sky.winbar").Winbar()'

return M
