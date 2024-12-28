vim.cmd.colorscheme("gruvbuddy")

-- General
vim.cmd("highlight ColorColumn ctermbg=0 guibg=#555555")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "ZenBg", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#000000", bg ="#000000" })

-- Spelling stuff
vim.api.nvim_set_hl(0, "SpellBad", { fg = "#A9352B" })
vim.api.nvim_set_hl(0, "SpellCap", { fg = "#A9352B" })

-- Line numbers
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#222222" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#222222" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFFF87" })

-- Tab line
vim.api.nvim_set_hl(0, "TabLine", { bg = "none", fg = "#222222" })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })

-- Markdown stuff
vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#111111" })
vim.api.nvim_set_hl(0, "RenderMarkdownTableFill", { bg = "none" })
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#B294BB" })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#FFFF87" })
vim.api.nvim_set_hl(0, "Title", { fg = "#87AFAF" })
vim.api.nvim_set_hl(0, "Underlined", { bg = "#222222" })

-- CMP menu
vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#FFFF87", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#B294BB" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#B294BB" })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#A9352B" })
