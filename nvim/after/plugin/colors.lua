vim.cmd.colorscheme("gruvbuddy")

vim.cmd("highlight ColorColumn ctermbg=0 guibg=#555555")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })

vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#000000" })

-- cmp
vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#FFFF87", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#B294BB" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#B294BB" })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#A9352B" })
