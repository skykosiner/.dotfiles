{ pkgs, ... }:

{
    home.packages = with pkgs; [
        alacritty
    ];

    programs.alacritty = {
        enable = true;
        settings = {
            window.opacity = 0.9;
            colors.primary.background = "#000000";
            font.size = 16;
            font.normal.family = "Berkeley Mono";
        };
    };
}
