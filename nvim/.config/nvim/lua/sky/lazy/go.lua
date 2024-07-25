return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup()

    local function tag(prompt_bufnr)
      local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
      )

      require("telescope.actions").close(prompt_bufnr)

      vim.cmd(":GoAddTag " .. content.value)
    end

    vim.keymap.set("n", "<leader>ta", function()
      require("telescope.pickers").new({}, {
        prompt_title = "Colors",
        finder = require("telescope.finders").new_table({
          results = {
            "json",
            "sql",
            "json,sql",
          }
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
          map("i", "<CR>", tag)
          return true
        end,
      }):find()
    end)
  end,
  event = { "CmdlineEnter" },
  ft = { "go", 'gomod' },
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
