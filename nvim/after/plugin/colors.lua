vim.opt.background = "light"

---@param color string
function _G.Colors(color)
    if vim.opt.background._value ~= "light" then
        vim.cmd.colorscheme(color or "gruvbox")

        -- General
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#555555" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#222222", bg = "#222222" })

        -- Line numbers
        -- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFF87", bg = "None" })
        -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#d5c4a1", bg = "None" })

        -- Markdown stuff
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#222222" })
        vim.api.nvim_set_hl(0, "RenderMarkdownTableFill", { bg = "none" })
        vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#B294BB" })
        vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#FFFF87" })
        vim.api.nvim_set_hl(0, "Title", { fg = "#87AFAF" })
        vim.api.nvim_set_hl(0, "Underlined", { bg = "#222222" })

        -- CMP menu
        vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#222222" })

        vim.api.nvim_set_hl(0, "TabLine", { bg = "none", fg = "#222222" })
        vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })

        -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

        -- Spelling stuff
        vim.api.nvim_set_hl(0, "SpellBad", { fg = "#A9352B" })
        vim.api.nvim_set_hl(0, "SpellCap", { fg = "#A9352B" })

        -- CMP STUFF
        vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#FFFF87", bold = true })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#B294BB" })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#B294BB" })
        vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#A9352B" })
        vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#333333" })
    else
        vim.cmd.colorscheme("catppuccin-latte")
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#222222" })
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#222222" })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#999999" })
        vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#999999" })
    end

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "ZenBg", { bg = "none" })

    -- vim.api.nvim_set_hl(0, "@markup.list.unchecked.markdown", { bg = "none", fg = "none" })
    -- vim.api.nvim_set_hl(0, "@markup.list.markdown", { bg = "none", fg = "none" })
end

_G.Colors()
