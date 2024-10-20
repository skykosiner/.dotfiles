{ pkgs, ... }:

{
  home.packages = with pkgs; [
      swww
      waybar
      hyprland
      rofi
      grim
      slurp
  ];

  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 14";
    theme = "/home/sky/.nix-profile/share/rofi/themes/solarized.rasi";
  };
}
