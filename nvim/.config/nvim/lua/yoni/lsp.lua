--local on_attach = require'completion'.on_attach

--require'lspconfig'.cssls.setup{ on_attach=on_attach }

--require'lspconfig'.tsserver.setup{ on_attach=on_attach }

--require'lspconfig'.gopls.setup{ on_attach=on_attach }

--require'lspconfig'.pyright.setup{ on_attach=on_attach }


--require'lspconfig'.clangd.setup {
    --on_attach=on_attach,
    --root_dir = function() return vim.loop.cwd() end
--}

local function on_attach()
end

require'lspconfig'.bashls.setup{ on_attach=on_attach }

require'lspconfig'.tsserver.setup{ on_attach=on_attach }

require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end
}

require'lspconfig'.jedi_language_server.setup{
    on_attach=on_attach,
}

--require'lspconfig'.yamlls.setup{}

require'lspconfig'.gopls.setup{
    on_attach=on_attach,
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}
-- who even uses this?
--
--require'lspconfig'.sumneko_lua.setup {
    --on_attach = on_attach,
    --cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    --settings = {
        --Lua = {
            --runtime = {
                ---- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                --version = 'LuaJIT',
                ---- Setup your lua path
                --path = vim.split(package.path, ';'),
            --},
            --diagnostics = {
                ---- Get the language server to recognize the `vim` global
                --globals = {'vim'},
            --},
            --workspace = {
                ---- Make the server aware of Neovim runtime files
                --library = {
                    --[vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    --[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                --},
            --},
        --},
    --},
--}

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides
    -- default: true
    show_guides = true,
}

--require('symbols-outline').setup(opts)

--local snippets_paths = function()
    --local plugins = { "friendly-snippets" }
    --local paths = {}
    --local path
    --local root_path = vim.env.HOME .. '/.vim/plugged/'
    --for _, plug in ipairs(plugins) do
        --path = root_path .. plug
        --if vim.fn.isdirectory(path) ~= 0 then
            --table.insert(paths, path)
        --end
    --end
    --return paths
--end

--require("luasnip.loaders.from_vscode").lazy_load({
    --paths = snippets_paths(),
    --include = nil,  -- Load all languages
    --exclude = {}
--})
