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

  wayland.windowManager.hyprland = {
      enable = true;
  };

  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 14";
    theme = "/home/sky/.nix-profile/share/rofi/themes/solarized.rasi";
  };


  gtk = {
      enable = true;
      font = {
        name = "Roboto";
        size = 10;
      };
      theme = {
          package = pkgs.orchis-theme;
          name = "Orchis-Grey-Dark";
      };
      iconTheme = {
          package = pkgs.tela-icon-theme;
          name = "Tela-blue-dark";

      };
      gtk3 = {
          bookmarks = [
              "file:///home/sky/Pictures/Captures/"
              "file:///home/sky/Documents/Linux-btw"
              "file:///home/sky/Documents/Linux-btw/Collage"
              "file:///home/sky/Documents/Memes"
              "file:///home/sky/Downloads"
              "file:///home/sky/personal"
              "file:///home/sky/work"
              "file:///home/sky/Pictures/"
          ];
          extraConfig = {
            gtk-key-theme-name = "Emacs";
          };
      };
  };


   dconf.settings = {
       "org/gtk/settings/file-chooser" = {
           sort-directories-first = true;
       };
   };

   # home.file.".config/gtk-3.0/settings.ini".text = ''
   #     [Settings]
   #     gtk-key-theme-name = Emacs
   # '';
}
