{ pkgs, ... }:

{
    home.packages = with pkgs; [
        alacritty
    ];

    programs.alacritty = {
        enable = true;
        settings = {
            window.opacity = 0.9;
            colors.primary.background = "#2A2F3A";
            font.size = 16;
            font.normal.family = "Berkeley Mono";
        };
    };
}
