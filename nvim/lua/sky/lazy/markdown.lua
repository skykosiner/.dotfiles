return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        ---@module "render-markdown"
        ---@type render.md.UserConfig
        opts = {
            code = {
                border = "none",
            },
            bullet = {
                enabled = false,
            },
            heading = {
                backgrounds = {},
                width = "block",
            }
        },
    }
}
