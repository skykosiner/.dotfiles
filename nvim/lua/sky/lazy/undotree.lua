return {
  {
    "mbbill/undotree",
    config = function()
      local opt = vim.opt

      opt.undofile = true
      opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
      opt.swapfile = false
      opt.backup = false

      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  }
}
