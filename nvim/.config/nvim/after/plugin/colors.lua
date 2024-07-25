vim.g.sky_color_scheme = "tokyonight"

require("onedark").load()

require('onedark').setup {
  transparent = true,
}

require("tokyonight").setup({
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    sidebars = "transparent",
    floats = "transparent",
  },
})

require("ayu").setup({
  mirage = false,
})

require("nightfox").setup({
  options = {
    transparent = true,
  }
})

require("catppuccin").setup({
  transparent_background = true,
})

require("gruvbox").setup({
  transparent_mode = true,
  contrast = "hard",
})

vim.opt.background = "dark"

require("rose-pine").setup({
  styles = {
    bold = true,
    italic = true,
    transparency = true,
  },
})

vim.g.gruvbox_material_contrast = "hard"
vim.g.gruvbox_material_transparent_background = 2
vim.g.gruvbox_material_better_performance = 1

if vim.g.sky_color_scheme ~= "gruvbuddy" then
  vim.cmd.colorscheme(vim.g.sky_color_scheme)
else
  vim.cmd.colorscheme(vim.g.sky_color_scheme)
  vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
  vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#bdbbbf" })
  vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#bdbbbf" })

  vim.api.nvim_set_hl(0, "@markup.heading", { fg = "#b294bb" })
end

vim.cmd("highlight ColorColumn ctermbg=0 guibg=#555555")
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#FFFF4E" })
