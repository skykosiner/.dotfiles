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
        history = false,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      }

      ls.add_snippets("lua", {
        snippet("@pa", {
          t("---@param "),
          i(1, "param"),
          t(" "),
          i(2, "type")
        }),

        -- TODO: Use choice node to pick between local function and global function
        snippet("f", {
          t("function "),
          i(1, "name"),
          t("("),
          i(2, "params"),
          t(")"),
          t({ "", "" }),
          t("end"),
        }),
      })

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
