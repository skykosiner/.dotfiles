local require = require

require("sky")

RELOAD = function(...)
  local ok, plenary_reload = pcall(require, "plenary.reload")
  if ok then
    reloader = plenary_reload.reload_module
  end

  return reloader(...)
end
