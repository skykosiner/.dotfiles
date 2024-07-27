-- This whole config has been stolen from tjdevries, I just changed a few bits
-- to fit me better

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.colors = {}
config.color_scheme = 'Gruvbox dark, medium (base16)'
config.colors.background = "#000000"

config.font = wezterm.font "BerkeleyMono Nerd Font"

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
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

return config
