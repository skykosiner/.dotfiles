{ pkgs, hostname, lib, ... }:

let
  fontsize = if (hostname == "nix-btw") then 18 else 15;
  dark = {
    # bg = "#1d2021";
    bg = "#2B2B2B";
    fg = "#d8dee9";
    dim_fg = "#a5abb6";
    cursor_bg = "#d8dee9";
    cursor_text = "#111111";
    selection_bg = "#4c566a";
    selection_text = "CellForeground";
    # Normal
    black = "#3b4252";
    red = "#bf616a";
    green = "#a3be8c";
    yellow = "#ebcb8b";
    blue = "#81a1c1";
    magenta = "#b48ead";
    cyan = "#88c0d0";
    white = "#e5e9f0";
    # Bright
    b_black = "#4c566a";
    b_red = "#bf616a";
    b_green = "#a3be8c";
    b_yellow = "#ebcb8b";
    b_blue = "#81a1c1";
    b_magenta = "#b48ead";
    b_cyan = "#8fbcbb";
    b_white = "#eceff4";
  };

  # --- LIGHT THEME (Gruvbox Material Light) ---
  light = {
    # bg = "#fbf1c7";
    bg = "#E0E2EA";
    fg = "#3c3836";
    dim_fg = "#7c6f64";
    cursor_bg = "#3c3836";
    cursor_text = "#fbf1c7";
    selection_bg = "#d5c4a1";
    selection_text = "CellForeground";
    # Normal
    black = "#282828";
    red = "#9d0006";
    green = "#79740e";
    yellow = "#b57614";
    blue = "#076678";
    magenta = "#8f3f71";
    cyan = "#427b58";
    white = "#7c6f64";
    # Bright
    b_black = "#928374";
    b_red = "#cc241d";
    b_green = "#98971a";
    b_yellow = "#d79921";
    b_blue = "#458588";
    b_magenta = "#b16286";
    b_cyan = "#689d6a";
    b_white = "#a89984";
  };

  # Helper function to generate the TOML string
  mkAlacrittyTheme = c: ''
    [colors.primary]
    background = "${c.bg}"
    foreground = "${c.fg}"
    dim_foreground = "${c.dim_fg}"

    [colors.cursor]
    text = "${c.cursor_text}"
    cursor = "${c.cursor_bg}"

    [colors.vi_mode_cursor]
    text = "${c.cursor_text}"
    cursor = "${c.cursor_bg}"

    [colors.selection]
    text = "${c.selection_text}"
    background = "${c.selection_bg}"

    [colors.normal]
    black = "${c.black}"
    red = "${c.red}"
    green = "${c.green}"
    yellow = "${c.yellow}"
    blue = "${c.blue}"
    magenta = "${c.magenta}"
    cyan = "${c.cyan}"
    white = "${c.white}"

    [colors.bright]
    black = "${c.b_black}"
    red = "${c.b_red}"
    green = "${c.green}"
    yellow = "${c.yellow}"
    blue = "${c.b_blue}"
    magenta = "${c.b_magenta}"
    cyan = "${c.b_cyan}"
    white = "${c.white}"
  '';

in {
  home.packages = with pkgs; [ alacritty ];
  xdg.configFile."alacritty/themes/dark.toml".text = mkAlacrittyTheme dark;
  xdg.configFile."alacritty/themes/light.toml".text = mkAlacrittyTheme light;

  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ "~/.config/alacritty/active_theme.toml" ];

      window = {
        opacity = 1;
        padding = {
          x = 0;
          y = 0;
        };
      };

      font.size = fontsize;
      # font.normal.family = "Iosevka Nerd Font";
      font.normal.family = "TX-02";
      # font.normal.family = "GoMono Nerd Font Mono";
      # font.normal.family = "ComicShanns Mono Nerd Font";

      keyboard.bindings = [{
        key = "G";
        mods = "Super|Shift";
        command = "/home/sky/.local/bin/alacrittyTransparrent";
      }];
    };
  };
}
