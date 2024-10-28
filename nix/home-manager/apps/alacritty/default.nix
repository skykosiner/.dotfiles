{ pkgs, hostname, ... }:

let
    fontsize = if (hostname == "nix-btw") then 14 else 12;
in {
    home.packages = with pkgs; [
        alacritty
    ];

    programs.alacritty = {
        enable = true;
        settings = {
            window.opacity = 0.9;
            colors.primary.background = "#2A2F3A";
            font.size = fontsize;
            font.normal.family = "Berkeley Mono";
        };
    };
}
