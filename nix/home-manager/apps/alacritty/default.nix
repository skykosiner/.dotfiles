{ pkgs, hostname, ... }:

let
    fontsize = if (hostname == "nix-btw") then 14 else 15;
in {
    home.packages = with pkgs; [
        alacritty
    ];

    programs.alacritty = {
        enable = true;
        settings = {
            window= {
                opacity = 0.9;
                padding = {
                    x = 20;
                    y = 20;
                };
            };
            colors.primary.background = "#2A2F3A";
            font.size = fontsize;
            font.normal.family = "Berkeley Mono";
        };
    };
}
