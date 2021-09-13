local on_attach = require'completion'.on_attach

require'lspconfig'.cssls.setup{ on_attach=on_attach }

require'lspconfig'.tsserver.setup{ on_attach=on_attach }

require'lspconfig'.gopls.setup{ on_attach=on_attach }

require'lspconfig'.jedi_language_server.setup{ on_attach=on_attach }

require'lspconfig'.bashls.setup{ on_attach=on_attach }

require'lspconfig'.clangd.setup {
    on_attach=on_attach,
    root_dir = function() return vim.loop.cwd() end
}
