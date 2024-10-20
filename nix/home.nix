{ config, pkgs, ... }:

let
  # Import your development module
  development = import ./modules/development.nix { inherit pkgs; };
  desktop = import ./modules/desktop-environment.nix { inherit pkgs; };

in {
    imports = [
        development
        desktop
    ];

    home.username = "sky";
    home.homeDirectory = "/home/sky";
    xdg.dataHome = "/home/sky/.local/share/";
    home.stateVersion = "24.05";

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
        teams-for-linux
        pfetch
        (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];

    home.file = {
        ".zshrc".source = ../zsh/.zshrc;
        ".zshenv".source = ../zsh/.zshenv;
    };

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    programs.git = {
        enable = true;
        userName = "Sky Kosiner";
        userEmail = "sky@skykosiner.com";
    };

    xdg = {
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
        };
    };

    programs.home-manager.enable = true;
}
