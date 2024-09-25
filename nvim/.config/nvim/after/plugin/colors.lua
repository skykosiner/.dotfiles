vim.cmd.colorscheme("gruvbox")

vim.cmd("highlight ColorColumn ctermbg=0 guibg=#555555")
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9EBDE8" })
vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
