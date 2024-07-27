return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "onsails/lspkind-nvim",
    },
    config = function()
        vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy" }
        vim.opt.shortmess:append "c"

        local lspkind = require("lspkind")
        local cmp = require("cmp")
        lspkind.init {}

        cmp.setup({
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "Normal:CmpNormal",
                }
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-Space>"] = cmp.mapping.complete({}),
                ["<C-y>"] = cmp.mapping(
                    cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                    { "i", "c" }
                ),
            }),
            experimental = {
                ghost_text = true,
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "nvim_lua" },
                { name = "luasnip" },
                { name = "buffer",        keyword_length = 5 },
                { name = "nvim_px_to_rem" }
            }
        })
    end
}
