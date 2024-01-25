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
        "doom-one",
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

-- Open my current dir in lf (termianl file manger) with a quick hotkey
function M.open_dir_lf()
  local currentDir = vim.loop.cwd()
  Job:new({
    "wezterm",
    "-e",
    "lfub",
    currentDir
  }):start()
end

local function ExtractLink(line)
  local pattern = "(http[s]?://%S+)"
  local link = string.match(line, pattern)
  return link
end

function M.open_markdown_link()
  local current_line = vim.api.nvim_get_current_line()
  local link = ExtractLink(current_line)

  if link then
    Job:new({
      "brave",
      link
    }):start()
  end
end

return M
