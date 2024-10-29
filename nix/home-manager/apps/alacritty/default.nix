{ pkgs, hostname, ... }:

let
    fontsize = if (hostname == "nix-btw") then 15 else 12;
in {
    home.packages = with pkgs; [
        alacritty
    ];

    programs.alacritty = {
        enable = true;
        settings = {
            window.opacity = 0.7;
            colors.primary.background = "#2A2F3A";
            font.size = fontsize;
            font.normal.family = "Berkeley Mono";
        };
    };
}
