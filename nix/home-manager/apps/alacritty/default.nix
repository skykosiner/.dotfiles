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
            window = {
                opacity = 0.70;
                padding = {
                    x = 10;
                    y = 10;
                };
            };
            # colors.primary.background = "#2A2F3A";
            colors.primary.background = "#000000";
            font.size = fontsize;
            font.normal.family = "Berkeley Mono";
            # font.normal.family = "JetbrainsMono Nerd Font";
        };
    };
}
