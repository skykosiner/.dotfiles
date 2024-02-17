return {
  {
    "tjdevries/colorbuddy.nvim",
    dependencies = {
      { "catppuccin/nvim",  name = "catppuccin", priority = 1000 },
      { "rose-pine/neovim", name = "rose-pine" },
      "gruvbox-community/gruvbox",
      "ayu-theme/ayu-vim",
      "folke/tokyonight.nvim",
      "tjdevries/gruvbuddy.nvim",
    },
    config = function()
      local Group = require("colorbuddy.group").Group
      local c = require("colorbuddy.color").colors
      local g = require("colorbuddy.group").groups
      local s = require("colorbuddy.style").styles

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

      require("catppuccin").setup({
        transparent_background = true,
      })


      vim.g.tokyonight_transparent = true
      vim.g.tokyonight_transparent_sidebar = true
      vim.opt.background = "dark"

      vim.g.sky_color_scheme = "catppuccin"

      require("rose-pine").setup({
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })

      -- Make that gruvbox look good
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.g.gruvbox_invert_selection = '0'
      vim.g.gruvbox_italic = 1

      if vim.g.sky_color_scheme ~= "gruvbuddy" then
        vim.cmd.colorscheme(vim.g.sky_color_scheme)
      else
        print("test???")
        require("colorbuddy").colorscheme("gruvbuddy")
        vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
        vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#bdbbbf" })
        vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#bdbbbf" })

        vim.api.nvim_set_hl(0, "@markup.heading", { fg = "#b294bb" })

        -- Stolen from tjdevries
        Group.new("@variable", c.purple:light():light(), nil)

        Group.new("GoTestSuccess", c.green, nil, s.bold)
        Group.new("GoTestFail", c.red, nil, s.bold)

        Group.new("TSPunctBracket", c.orange:light():light())

        Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
        Group.new("StatuslineError2", c.red:light(), g.Statusline)
        Group.new("StatuslineError3", c.red, g.Statusline)
        Group.new("StatuslineError3", c.red:dark(), g.Statusline)
        Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)

        Group.new("pythonTSType", c.red)
        Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)

        Group.new("typescriptTSConstructor", g.pythonTSType)
        Group.new("typescriptTSProperty", c.blue)

        Group.new("WinSeparator", nil, nil)

        Group.new("TSTitle", c.blue)

        Group.new("InjectedLanguage", nil, g.Normal.bg:dark())

        Group.new("LspParameter", nil, nil, s.italic)
        Group.new("LspDeprecated", nil, nil, s.strikethrough)
        Group.new("@function.bracket", g.Normal, g.Normal)
        Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

        Group.new("VirtNonText", c.yellow:light():light(), nil, s.italic)
        Group.new("VirtNonText", c.gray3:dark(), nil, s.italic)

        Group.new("TreesitterContext", nil, g.Normal.bg:light())
        Group.new("TreesitterContextLineNumber", c.blue)

        Group.new("@property", c.blue)
        Group.new("@punctuation.bracket.rapper", c.gray3, nil, s.none)
        Group.new("@rapper_argument", c.red, nil, s.italic)
        Group.new("@rapper_return", c.orange:light(), nil, s.italic)
        Group.new("@constructor.ocaml", c.orange:light(), nil, s.none)
        Group.new("constant", c.orange, nil, s.none)

        Group.new("@keyword", c.violet, nil, s.none)
        Group.new("@keyword.faded", g.nontext.fg:light(), nil, s.none)

        Group.new("Function", c.yellow, nil, s.none)

        vim.cmd [[
        hi link @function.call.lua LuaFunctionCall
        hi link @lsp.type.variable.lua variable
        hi link @lsp.type.variable.rust variable
        hi link @lsp.type.namespace @namespace
        hi link @punctuation.bracket.rapper @text.literal
        hi link @normal Normal
        ]]

        Group.new("Normal", c.superwhite, c.gray0)
      end

      vim.cmd("highlight ColorColumn ctermbg=0 guibg=#555555")
      vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end
  }
}
