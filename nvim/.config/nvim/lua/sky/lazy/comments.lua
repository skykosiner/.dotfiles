return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        opleader = {
          line = "gc",
          block = "gb",
        },

        mappings = {
          basic = true,
          extra = true,
          extended = true,
        },

        toggler = {
          line = "gcc",
          block = "gbc",
        },

        pre_hook = nil,
        post_hook = nil,
        ignore = nil,
      }

      local comment_ft = require "Comment.ft"
      comment_ft.set("lua", { "--%s", "--[[%s]]" })
    end
  }
}
