local Group = require("colorbuddy.group").Group

function Colors(color)
  vim.g.sky_colorscheme = color or 'gruvbuddy'

  require("colorizer").setup()
  require("colorbuddy").setup()

  -- Make sure rose-pine is 100% transparent
  require("rose-pine").setup({
    disable_background = true
  })

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

    highlight SignColumn guibg=none
    highlight netrwDir guifg=#aaaaff
    highlight qfFileName guifg=#aed75f
    highlight TelescopeBorder guifg=#5eacd
    highlight CursorLineNR guibg=None
    highlight Tabline guibg=None
    highlight TablineSel guibg=None
    highlight TablineFill guibg=None

    highlight TelescopePromptPrefix guifg=#96f1ff

    " Idk make vim.notify shutup
    highlight background_color guifg=#373b40 guibg=#7fa3c0

    " highlight netrwDir guifg=#5eacd3
    " highlight LineNr guifg=#5eacd3 guibg=None
    highlight LineNr guibg=None

    " gray
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#880808
    " blue
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#aaaaff
    highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
    ]])

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  -- Make sure tokyonight is 100% transparent
  require("tokyonight").setup({
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      sidebars = "transparent",
      floats = "transparent",
    },
  })

  -- Set statusline to correct colors
  vim.api.nvim_set_hl(0, "Ignore", { bg = "#7fa3c0", fg = "#2e2e2e" })
  vim.api.nvim_set_hl(0, "", {})
end

Colors()
