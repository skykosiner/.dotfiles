{ pkgs, ... }:

{
  home.packages = with pkgs; [
      swww
      wtype
      waybar
      ffmpegthumbnailer
      poppler_utils
      python312Packages.docx2txt
      exiftool
      catdoc
      msmtp
      mediainfo
      lynx
      atool
      hyprland
      pulsemixer
      rofi
      grim
      slurp
      libnotify
      lf
      ueberzugpp
      hyprlock
      swayidle
      wl-clipboard
  ];

  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 14";
    theme = "/home/sky/.nix-profile/share/rofi/themes/solarized.rasi";
  };

}
