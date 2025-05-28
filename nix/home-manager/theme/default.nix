{ pkgs, hostname, lib, ... }:

let desktop = (hostname == "nix-btw");
in {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    font = {
      name = "Roboto";
      size = 16;
    };
    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-blue-dark";

    };
    gtk3 = {
      bookmarks = lib.optionals desktop [ "file:///home/sky/Documents/Memes" ]
        ++ [
          "file:///mnt/server"
          "file:///mnt/ssd"
          "file:///home/sky/Pictures/Captures"
          "file:///home/sky/Documents/Linux-btw"
          "file:///home/sky/Documents/Linux-btw/College"
          "file:///home/sky/Downloads"
          "file:///home/sky/personal"
          "file:///home/sky/work"
          "file:///home/sky/Pictures"
          "file:///home/sky/.dotfiles/backgrounds"
        ];
      extraConfig = { gtk-key-theme-name = "Emacs"; };
    };
  };

  dconf.settings = {
    "org/gtk/settings/file-chooser" = { sort-directories-first = true; };
  };

  home.packages = with pkgs; [ libsForQt5.qt5ct ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "Fusion";
  };
}
