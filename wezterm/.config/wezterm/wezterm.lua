local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- config.keys = {
--     { key = "J", mods = "SHIFT", action = act.ScrollByLine(1), },
--     { key = "k", mods = "SHIFT", action = act.ScrollByLine(-1), },
-- }

config.colors = {}
config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.colors.background = "#000000"
config.colors.background = "#111111"

config.font = wezterm.font "BerkeleyMono Nerd Font"
-- config.font = wezterm.font "Iosevka Nerd Font"
config.font_size = 16

config.use_fancy_tab_bar = false

config.enable_scroll_bar = false
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.audible_bell = "Disabled"

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

config.window_close_confirmation = 'NeverPrompt'
config.hide_tab_bar_if_only_one_tab = true

return config
