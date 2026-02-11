local koreader_src = vim.fn.expand("~/personal/koreader")

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
        ft = "lua",
        opts = {
            library = {
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

            local simple_servers = { "html", "cssls", "clangd", "rust_analyzer", "sqls", "templ" }
            for _, name in ipairs(simple_servers) do
                vim.lsp.config(name, {})
            end

            -- lsp.extend_lspconfig()
            -- lsp.setup_servers({
            --     "basedpyright",
            --     "lua_ls",
            --     "html",
            --     "cssls",
            --     "gopls",
            --     "clangd",
            --     "rust_analyzer",
            --     "lua_ls",
            --     "vtsls",
            --     "sqls",
            --     "templ",
            --     "nixd"
            -- })
            --

            -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("nixd", {
                cmd = { "nixd" },
                -- capabilities = capabilities, -- ADD THIS LINE
                settings = {
                    nixd = {
                        nixpkgs = {
                            expr = [[import (builtins.getFlake "/home/sky/.dotfiles/nix/").inputs.nixpkgs { }]],
                        },
                        formatting = {
                            command = { "nixfmt" }, -- or nixfmt or nixpkgs-fmt
                        },
                        options = {
                            nixos = {
                                expr = '(builtins.getFlake "/home/sky/.dotfiles/nix/").nixosConfigurations.nix-btw.options',
                            },
                            home_manager = {
                                expr = '(builtins.getFlake "/home/sky/.dotfiles/nix/").homeConfigurations."sky@nix-btw".options',
                            },
                            -- nix_server = {
                            --     expr = '(builtins.getFlake "/home/sky/personal/nix-server/").nixosConfigurations.main-box.options',
                            -- },
                        },
                    },
                },
            })

            -- require("lspconfig").nixd.setup {
            --     settings = {
            --         nixd = {
            --             nixpkgs = {
            --                 expr = "import <nixpkgs> { }",
            --             },
            --             formatting = {
            --                 command = { "nixfmt" },
            --             },
            --             options = {
            --                 nixos = {
            --                     expr = '(builtins.getFlake "/PATH/TO/FLAKE").nixosConfigurations.CONFIGNAME.options',
            --                 },
            --                 home_manager = {
            --                     expr = '(builtins.getFlake "/PATH/TO/FLAKE").homeConfigurations.CONFIGNAME.options',
            --                 },
            --             },
            --         },
            --     },
            -- }

            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        ["ui.inlayhint.hints"] = {
                            compositeLiteralFields = false,
                            constantValues = false,
                            parameterNames = false
                        },
                    },
                },
            })

            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = true
                        }
                    }
                }
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                koreader_src .. "/frontend",
                                koreader_src .. "/base",
                            },
                        },
                    }
                }
            })

            vim.lsp.config("html", {
                filetypes = { "html", "templ" },
            })

            vim.lsp.config("vtsls", {
                filetypes = { "javascrit", "typescript", "react" },
                settings = {
                    typescript = {
                        inlayHints = {
                            -- parameterNames = { enabled = "all" },
                            parameterTypes = { enabled = false },
                            variableTypes = { enabled = false },
                            propertyDeclarationTypes = { enabled = false },
                            functionLikeReturnTypes = { enabled = false },
                            enumMemberValues = { enabled = false },
                        },
                    },
                },
            })

            vim.keymap.set("n", "<leader>qf", vim.diagnostic.setqflist)

            lsp.on_attach(function(_, bufnr)
                -- TURN ON THEM HINTS BBG
                vim.lsp.inlay_hint.enable(false)

                -- GIVE ME MY KEYBINDS
                local opts = { buffer = bufnr, remap = false }
                local builtin = require "telescope.builtin"

                vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
                vim.keymap.set("n", "<leader>vrr", builtin.lsp_references, opts)

                vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
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
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                go = { "goimports", "gofmt", "golines" },
                templ = { "templ" },
                lua = { "stylua" },
            },
            format_after_save = {
                lsp_fallback = true,
            },
        }
    }
}
