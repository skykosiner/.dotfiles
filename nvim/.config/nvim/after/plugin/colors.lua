vim.g.sky_color_scheme = "gruvbox-material"

vim.opt.background = "dark"

vim.cmd.colorscheme(vim.g.sky_color_scheme)

vim.cmd("highlight ColorColumn ctermbg=0 guibg=#555555")
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#FFFF4E" })
vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
