return {
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
                    "ts_ls",
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
                    ["ts_ls"] = function()
                        lspconfig.ts_ls.setup {
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
            vim.diagnostic.config { jump = { float = true } }
            local lsp = require("lsp-zero")
            lsp.extend_lspconfig()
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
    {
        "VidocqH/lsp-lens.nvim",
        config = function()
            require("lsp-lens").setup({
                on_attach = function(client, bufnr)
                    vim.keymap.set("n", "gl", function()
                        require("lsp-lens").lens_info(bufnr)
                    end, { buffer = bufnr, silent = true })
                end,
            })
        end
    },
    {
        "codota/tabnine-nvim",
        build = "./dl_binaries.sh",
        config = function()
            require('tabnine').setup({
                disable_auto_comment=true,
                accept_keymap="<Tab>",
                dismiss_keymap = "<C-]>",
                debounce_ms = 800,
                suggestion_color = {gui = "#808080", cterm = 244},
                exclude_filetypes = {"TelescopePrompt", "NvimTree"},
                log_file_path = "/home/sky/.cache/tabnine-nvim.log",
                ignore_certificate_errors = false,
            })
        end,
    },
}
