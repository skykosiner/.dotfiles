local function play_playlist(prompt_bufnr, map)
  local function run_me_daddy(close)
    local content = require("telescope.actions.state").get_selected_entry(
      prompt_bufnr
    )

    if close then
      require("telescope.actions").close(prompt_bufnr)
    end

    local id = vim.fn.systemlist(string.format([[ echo "%s" | awk -F 'id: ' '{print $2}' ]], content.value))[1]

    vim.fn.system(string.format([[
    qdbus org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.OpenUri \
    spotify:album:%s
    ]], id))
  end

  map("i", "<C-s>", function()
    run_me_daddy(false)
  end)

  map("i", "<CR>", function()
    run_me_daddy(true)
  end)
end

local function select_song()
  local albums = vim.fn.systemlist([[ cat ~/.dotfiles/album_list | awk -F '|' '{print $1 " - "  $2 " id: " $3}']])
  require("telescope.pickers").new({}, {
    prompt_title = "< Chose Album >",
    finder = require("telescope.finders").new_table({
      results = albums
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      play_playlist(prompt_bufnr, map)

      return true
    end,
  }):find()
end

vim.keymap.set("n", "<leader>ssp", function()
  select_song()
end)
