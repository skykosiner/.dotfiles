function string.split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function play_playlist(prompt_bufnr)
  local content = require("telescope.actions.state").get_selected_entry(
    prompt_bufnr
  )

  require("telescope.actions").close(prompt_bufnr)

  local id = string.split(content.value, "id :")
  vim.fn.system(string.format([[
  qdbus org.mpris.MediaPlayer2.spotify \
  /org/mpris/MediaPlayer2 \
  org.mpris.MediaPlayer2.Player.OpenUri \
  spotify:album:%s
  ]], id[#id]))
end

local function select_song()
  local albums = vim.fn.systemlist([[ cat ~/.dotfiles/album_list | awk -F '|' '{print $1 " - "  $2 " id: " $3}']])
  require("telescope.pickers").new({}, {
    prompt_title = "Chose playlis",
    finder = require("telescope.finders").new_table({
      results = albums
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(_, map)
      map("i", "<CR>", play_playlist)
      return true
    end,
  }):find()
end

vim.keymap.set("n", "<leader>ssp", function()
  select_song()
end)
