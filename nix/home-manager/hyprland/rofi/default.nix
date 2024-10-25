{ pkgs, ... }:

{
  home.packages = with pkgs; [
      rofi
  ];

  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 14";
    theme = "/home/sky/.nix-profile/share/rofi/themes/solarized.rasi";
  };
}
