{ config, pkgs, ... }:

let
  # Import your development module
  development = import ./modules/development.nix { inherit pkgs; };
  desktop = import ./modules/desktop-environment.nix { inherit pkgs; };
  video = import ./modules/video-setup.nix { inherit pkgs; };
  apps = import ./modules/applications.nix { inherit pkgs; };

in {
    imports = [
        development
        desktop
        video
        apps
    ];

    home.username = "sky";
    home.homeDirectory = "/home/sky";
    xdg.dataHome = "/home/sky/.local/share/";
    home.stateVersion = "24.05";

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
        teams-for-linux
        pfetch
        killall
        udiskie
        (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];

    home.file = {
        ".zshrc".source = ../zsh/.zshrc;
        ".zshenv".source = ../zsh/.zshenv;
    };

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
        configFile = {
            "waybar" = {
                source = ../waybar/.config/waybar;
            };
            "hypr" = {
                source = ../hypr/.config/hypr;
            };
            "nvim" = {
                source = ../nvim/.config/nvim;
            };
            "tmux" = {
                source = ../tmux/.config/tmux;
            };
            "personal" = {
                source = ../shell/.config/personal;
            };
            "lf" = {
                source = ../lf/.config/lf;
            };
        };
    };

    programs.home-manager.enable = true;
}
