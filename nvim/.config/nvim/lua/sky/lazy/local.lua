return {
  dir = os.getenv("HOME") .. "/personal/todoist.nvim/",
  config = function()
    local todoist_api_key = os.getenv("TODOIST_API_TOKEN")
    local todoist = require("todoist")
    todoist:setup({
      api_key = todoist_api_key,
      update_time = 5000,
    })

    vim.keymap.set("n", "<leader>td", function()
      todoist:today()
    end)

    vim.keymap.set("n", "<leader>tp", function()
      todoist:view_project()
    end)

    vim.keymap.set("n", "<leader>tn", function()
      todoist:create_task()
    end)
  end
}
