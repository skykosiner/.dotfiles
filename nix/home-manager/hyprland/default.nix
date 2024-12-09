{ pkgs, ... }:

{
    imports = [
        ./rofi
        ./fuzzel
        ./waybar
    ];

    home.packages = with pkgs; [
        swww
        mpvpaper
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
        hyprpicker
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
