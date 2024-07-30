return {
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup {}
        end
    },
    {
        "jsongerber/nvim-px-to-rem",
        config = function()
            require("nvim-px-to-rem").setup {}
        end
    },
    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup {}
        end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup {}
        end
    },
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local lsp = require "lsp-zero"
            local lspconfig = require "lspconfig"
            require('mason-lspconfig').setup {
                ensure_installed = {
                    "bashls",
                    "clangd",
                    "cssls",
                    "gopls",
                    "html",
                    "lua_ls",
                    "pyright",
                    "rust_analyzer",
                    "tailwindcss",
                    "tsserver",
                    "vimls",
                    "yamlls",
                },
                handlers = {
                    lsp.default_setup,
                    ["gopls"] = function()
                        lspconfig.gopls.setup {
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
                    end,
                    ["tsserver"] = function()
                        lspconfig.tsserver.setup {
                            settings = {
                                typescript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = 'all',
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    }
                                },
                                javascript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = 'all',
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    }
                                }
                            }
                        }
                    end
                },
            }
        end
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        config = function()
            local lsp = require("lsp-zero")
            lsp.extend_lspconfig()
            lsp.on_attach(function(_, bufnr)
                -- TURN ON THEM HINTS BBG
                vim.lsp.inlay_hint.enable(true)

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
