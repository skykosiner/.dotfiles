{ pkgs, ... }:

{
    home.packages = with pkgs; [
        starship
    ];

    programs.starship = {
        enable = true;
        settings = {
            add_newline = false;
        };
    };
}
