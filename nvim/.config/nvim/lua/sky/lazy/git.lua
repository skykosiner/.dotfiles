return {
  "TimUntersberger/neogit",
  config = function()
    require("neogit").setup({})
    vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit)
  end
}
