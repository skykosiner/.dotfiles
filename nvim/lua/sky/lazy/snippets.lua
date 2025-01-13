return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
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

            -- Lua snippets
            ls.add_snippets("lua", {
                snippet("@pa", {
                    t("---@param "), i(1, "param"), t(" "), i(2, "type")
                }),
                snippet("f", {
                    t("function "), i(1, "name"), t("("), i(2, "params"), t(")"), t({ "", "    " }),
                    i(3, "-- function body"), t({ "", "end" })
                }),
            })

            -- markdown
            ls.add_snippets("markdown", {
                snippet("out", {
                    t { "As always,",
                        "Sincerely yours,",
                        "Sky ❤️"
                    }
                }),
            })

            ls.add_snippets("python", {
                snippet("start", {
                    t "def main():",
                    t { "", "    " }, i(1, "# function body"), t { "", "    " },
                    t {
                        "",
                        'if __name__ == "__main__":',
                        "     main()"
                    }
                }),
            })

            -- Go snippets
            ls.add_snippets("go", {
                snippet("ee", {
                    t("if err != nil {"), t({ "", "    " }), i(1, "// handle error"), t({ "", "}" })
                }),
                snippet("fh", {
                    t("func "), i(1, "name"), t("(w http.ResponseWriter, r *http.Request"), i(2, "args"), t(") {"),
                    t({ "", "    " }), i(3, "// function body"), t({ "", "}" })
                }),
                snippet("ft", {
                    t("func Test"), i(1, "Name"), t("(t *testing.T) {"),
                    t({ "", "    " }), i(2, "// test logic here"), t({ "", "}" })
                }),
                snippet("f", {
                    t("func "), i(1, "name"), t("("), i(2, "args"), t(")"),
                    i(3, " returnType"), t(" {"),
                    t({ "", "    " }), i(4, "// function body"), t({ "", "}" })
                }),
            })

            -- Key mappings
            vim.keymap.set({ "i", "s" }, "<C-e>", function() ls.expand() end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
        end,
    },
}
