return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      local ls = require("luasnip")
      local snippet = ls.s
      local t = ls.text_node
      local i = ls.insert_node

      require("luasnip.loaders.from_vscode").lazy_load()

      ls.config.set_config {
        -- This tells LuaSnip to remember to keep around the last snippet.
        -- You can jump back into it even if you move outside of the selection
        history = false,

        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        updateevents = "TextChanged,TextChangedI",

        -- Autosnippets:
        enable_autosnippets = true,

        -- Crazy highlights!!
        -- #vid3
        -- ext_opts = nil,
      }

      ls.add_snippets("go", {
        snippet("ee", {
          t("if err != nil {"),
          t({ "", "" }),
          i(1, "    "),
          t({ "", "" }),
          t("}")
        }),

        snippet("f", {
          t("func "),
          i(1, "name"),
          t("("),
          i(2, "args"),
          t(")"),
          i(3, "return"),
          t("{"),
          t({ "", "" }),
          t "}"
        }),
      })


      vim.keymap.set({ "i", "s" }, "<C-e>", function() ls.expand() end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  }
}
