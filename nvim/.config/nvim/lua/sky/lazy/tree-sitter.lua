return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
        require "nvim-treesitter".setup {
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "c", "lua", "rust", "jsdoc", "bash", "json", "yaml", "css", "html", "scss", "tsx",
            },
            sync_install = false,
            auto_install = true,
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
