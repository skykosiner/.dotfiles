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
    prompt_title = "Colors",
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

function M.toggleSpell()
  -- Toggle spelling on or off
  if vim.o.spell then
    vim.o.spell = false
  else
    vim.o.spell = true
  end
end

-- Open my current dir in nnn (termianl file manger) with a quick hotkey
function M.open_dir_nnn()
  local currentDir = vim.cmd("pwd")
  Job:new({
    "st",
    "-e",
    "nnn",
    currentDir
  }):start()
end

return M
