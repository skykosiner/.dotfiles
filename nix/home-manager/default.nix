{ config, pkgs, lib, hostname, inputs, system, ... }:

let
  apps = import ./apps { inherit pkgs; };
  theme = import ./theme { inherit pkgs lib hostname; };
  hyprland = import ./hyprland { inherit pkgs; };
  development = import ./development { inherit pkgs; };

in {
    imports = [
        apps
        theme
        hyprland
        development
    ];

    home.username = "sky";
    home.homeDirectory = "/home/sky";
    xdg.dataHome = "/home/sky/.local/share/";
    home.stateVersion = "24.05";

    programs.emacs = {
        enable = true;
        # package = pkgs.emacsGcc; # You can use `pkgs.emacs` or other variants as needed
    };

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
        highlight
        lolcat
        figlet
        cowsay
        gh-markdown-preview
        groff
        pfetch
        killall
        udiskie
        ffmpegthumbnailer
        pandoc
        poppler_utils
        python312Packages.docx2txt
        exiftool
        networkmanagerapplet
        flat-remix-gtk
        catdoc
        msmtp
        mediainfo
        lynx
        atool
        pulsemixer
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    services.udiskie = {
        enable = true;
    };

    xdg = {
        mimeApps = {
            enable = true;
            defaultApplications = {
                "image/jpeg" = [ "nsxiv.desktop" ];
                "image/png" = [ "nsxiv.desktop" ];
                "text/plain" = [ "nvim.desktop" ];
                "inode/directory" = [ "thunar.desktop" ];
                "x-scheme-handler/http" = [ "brave-browser.desktop" ];
                "x-scheme-handler/https" = [ "brave-browser.desktop" ];
                "x-scheme-handler/mailto" = [ "neomutt.desktop" ];
            };
        };
        enable = true;
    };

    programs.home-manager.enable = true;
}
