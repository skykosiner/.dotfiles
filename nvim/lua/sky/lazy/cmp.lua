return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "onsails/lspkind-nvim",
    },
    config = function()
        vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy" }
        vim.opt.shortmess:append "c"

        local lspkind = require("lspkind")
        local cmp = require("cmp")

        lspkind.init {}

        cmp.setup({
            formatting = {
                format = lspkind.cmp_format {
                    with_text = false,
                    menu = {
                        nvim_lsp = "[LSP]",
                        buffer = "[buf]",
                        lazydev = "[api]",
                        path = "[path]",
                        luasnip = "[snip]",
                        nvim_px_to_rem = "[PxRem]"
                    }
                },
                fields = {"menu", "kind", "abbr"},
                expandable_indicator = false
            },
            window = {
                completion = {
                    winhighlight = "Normal:CmpNormal",
                }
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
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
                { name = "buffer",        keyword_length = 5 },
                { name = "lazydev",       group_index = 0 },
                { name = "path" },
                { name = "luasnip" },
                { name = "nvim_px_to_rem" }
            }
        })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })

    end
}
