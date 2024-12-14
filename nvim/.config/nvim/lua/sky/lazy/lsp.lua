return {
    "neovim/nvim-lspconfig",
    {
        "jsongerber/nvim-px-to-rem",
        config = function()
            require("nvim-px-to-rem").setup {}
        end
    },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                },
            }
        end
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    {
        "VonHeikemen/lsp-zero.nvim",
        config = function()
            vim.diagnostic.config { jump = { float = true } }
            local lsp = require("lsp-zero")
            lsp.extend_lspconfig()
            lsp.setup_servers({
                "basedpyright",
                "lua_ls",
                "gopls",
                "rust_analyzer",
                "lua_ls",
                "vtsls",
            })

            require("lspconfig").gopls.setup {
                settings = {
                    gopls = {
                        ["ui.inlayhint.hints"] = {
                            compositeLiteralFields = true,
                            constantValues = true,
                            parameterNames = true
                        },
                    },
                },
            }

            require("lspconfig").basedpyright.setup {
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = true
                        }
                    }
                }
            }

            require("lspconfig").rust_analyzer.setup {
                settings = {
                    ["rust-analyzer"] = {
                        inlayHints = {
                            bindingModeHints = {
                                enable = true,
                            },
                            chainingHints = {
                                enable = true,
                            },
                            closingBraceHints = {
                                enable = true,
                                minLines = 25,
                            },
                            closureReturnTypeHints = {
                                enable = "never",
                            },
                            lifetimeElisionHints = {
                                enable = "never",
                                useParameterNames = false,
                            },
                            maxLength = 25,
                            parameterHints = {
                                enable = true,
                            },
                            reborrowHints = {
                                enable = "never",
                            },
                            renderColons = true,
                            typeHints = {
                                enable = true,
                                hideClosureInitialization = false,
                                hideNamedConstructor = false,
                            },
                        },
                    }
                }
            }

            require("lspconfig").lua_ls.setup {
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                        }
                    }
                }
            }

            require("lspconfig").vtsls.setup {
                settings = {
                    typescript = {
                        inlayHints = {
                            parameterNames = { enabled = "all" },
                            parameterTypes = { enabled = true },
                            variableTypes = { enabled = true },
                            propertyDeclarationTypes = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                            enumMemberValues = { enabled = true },
                        },
                    },
                },
            }

            lsp.on_attach(function(_, bufnr)
                -- TURN ON THEM HINTS BBG
                -- vim.lsp.inlay_hint.enable(true)

                -- GIVE ME MY KEYBINDS
                local opts = { buffer = bufnr, remap = false }
                local builtin = require "telescope.builtin"

                vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
                vim.keymap.set("n", "<leader>vrr", builtin.lsp_references, opts)

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
            end)


            lsp.setup()
        end
    },
}
