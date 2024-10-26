{ config, pkgs, ... }:

let
  apps = import ./apps { inherit pkgs; };
  theme = import ./theme { inherit pkgs; };
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

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
        pfetch
        killall
        udiskie
        ffmpegthumbnailer
        poppler_utils
        python312Packages.docx2txt
        exiftool
        networkmanagerapplet
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
                "image/jpeg" = [ "sxiv.desktop" ];
                "image/png" = [ "sxiv.desktop" ];
                "text/plain" = [ "nvim.desktop" ];
                "inode/directory" = [ "thunar.desktop" ];
                "x-scheme-handler/http" = [ "brave-browser.desktop" ];
                "x-scheme-handler/https" = [ "brave-browser.desktop" ];
                "x-scheme-handler/mailto" = [ "neomutt.desktop" ];
            };
        };
        enable = true;
    };

    home.file = {
        ".cloudflared/cert.pem".source = ../cert.pem;
    };

    programs.home-manager.enable = true;
}
