---@param color string
function Colors(color)
  vim.g.sky_colorscheme = color

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

  -- Make sure rose-pine is 100% transparent
  require("rose-pine").setup({
    disable_background = true
  })

  require("colorbuddy").setup()
  require('colorbuddy').colorscheme(vim.g.sky_colorscheme)
  require("colorizer").setup()

  vim.g.tokyonight_transparent = true
  vim.g.tokyonight_transparent_sidebar = true
  vim.opt.background = "dark"

  -- Make that gruvbox look good
  vim.g.gruvbox_contrast_dark = 'hard'
  vim.g.gruvbox_contrast_dark = 'hard'
  vim.g.gruvbox_invert_selection = '0'
  vim.g.gruvbox_italic = 1

  vim.cmd("highlight ColorColumn ctermbg=0 guibg=#555555")

  vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "none" })
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "netrwDir", { fg = "#aaaaff" })
  vim.api.nvim_set_hl(0, "qfFileName", { fg = "#aed75f" })
  -- vim.api.nvim_set_hl(0, "CursorLineNR", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#96f1ff" })
  vim.api.nvim_set_hl(0, "background_color", { fg = "#373b40", bg = "#7fa3c0" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = "#FFFFFF" })
  -- Set statusline to correct colors
  -- vim.api.nvim_set_hl(0, "Ignore", { bg = "#2e2e2e", fg = "#7fa3c0" })
end

Colors("tokyonight")
