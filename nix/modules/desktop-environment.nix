{ pkgs, ... }:

{
  home.packages = with pkgs; [
      swww
      libreoffice
      waybar
      hyprland
      zathura
      rofi
      grim
      slurp
      libnotify
      xfce.thunar
      lf
      ueberzugpp
      hyprlock
      swayidle
      spotify
      obsidian
      brave
      wl-clipboard
      sxiv
      bitwarden-desktop
      gimp
  ];

  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 14";
    theme = "/home/sky/.nix-profile/share/rofi/themes/solarized.rasi";
  };

  programs.zathura = {
      enable = true;
      extraConfig = ''
        set sandbox none
        set statusbar-h-padding 0
        set statusbar-v-padding 0
        set page-padding 1
        set selection-clipboard clipboard
        map u scroll half-up
        map d scroll half-down
        map D toggle_page_mode
        map r reload
        map R rotate
        map K zoom in
        map J zoom out
        map i recolor
        map p print
        map g goto top
      '';
  };
}
