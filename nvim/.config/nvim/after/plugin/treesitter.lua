require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "help", "javascript", "typescript", "c", "lua", "rust" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

require 'treesitter-context'.setup {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
}
