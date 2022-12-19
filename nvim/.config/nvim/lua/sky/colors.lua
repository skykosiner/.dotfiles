local Group = require("colorbuddy.group").Group

function Colors(color)
    vim.g.sky_colorscheme = color or 'gruvbuddy'
    Group.new("WinSeparator", nil, nil)

    require("colorizer").setup()
    require("colorbuddy").setup()

    -- Remove window border color thing - does not work 100% on gruvbox btw
    Group.new("WinSeparator", nil, nil)

    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_transparent_sidebar = true
    vim.opt.background = "dark"

    -- Make that gruvbox look good
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.gruvbox_invert_selection = '0'
    vim.g.gruvbox_italic = 1

    require('colorbuddy').colorscheme(vim.g.sky_colorscheme)

    vim.cmd([[
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    highlight ColorColumn ctermbg=0 guibg=#555555
    highlight SignColumn guibg=none
    highlight LineNr guifg=#aaaaff guibg=None
    highlight netrwDir guifg=#aaaaff
    highlight qfFileName guifg=#aed75f
    highlight TelescopeBorder guifg=#5eacd
    highlight CursorLineNR guibg=None
    highlight Tabline guibg=None
    highlight TablineSel guibg=None
    highlight TablineFill guibg=None

    highlight StatusLine ctermbg=24 ctermfg=254 guibg=#373b40 guifg=#7fa3c0
    highlight TelescopePromptPrefix guifg=#96f1ff
    highlight Ignore guifg=#373b40 guibg=#7fa3c0

    " Idk make vim.notify shutup
    highlight background_color guifg=#373b40 guibg=#7fa3c0

    " highlight netrwDir guifg=#5eacd3
    highlight LineNr guifg=#5eacd3 guibg=None

    " gray
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#880808
    " blue
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#aaaaff
    highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
    ]])

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

Colors()
