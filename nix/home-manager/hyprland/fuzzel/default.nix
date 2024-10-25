{ pkgs, hostname, ... }:
let
  fontSize = if (hostname == "nix-btw") then "16" else "10";
in {
    home.packages = with pkgs; [
        fuzzel
        bemoji
    ];
    programs.fuzzel = {
        enable = true;
        settings = {
            colors.background = "3D4455DD";
            main = {
                font = "Berkeley Mono:size=${fontSize}";
                lines = 16;
                terminal = "alacritty";
                tabs = 2;
                width = 32;
                horizontal-pad = 32;
                vertical-pad = 32;
                inner-pad = 32;
            };
            border = {
                width = 2;
                radius = 8;
            };
        };
    };
}
