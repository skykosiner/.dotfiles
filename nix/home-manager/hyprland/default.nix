{ pkgs, ... }:

{
    imports = [
        ./rofi
        ./fuzzel
        ./waybar
    ];

    home.packages = with pkgs; [
        swww
        wtype
        hyprland
        grim
        hyprcursor
        slurp
        libnotify
        hyprlock
        swayidle
        wl-clipboard
        networkmanagerapplet
    ];

    wayland.windowManager.hyprland = {
        enable = true;
    };

    xdg.configFile = {
        "hypr" = {
            source = ../../../hypr/.config/hypr;
        };
    };
}
