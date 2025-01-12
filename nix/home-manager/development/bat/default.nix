{ pkgs, ... }:

{
    home.packages = with pkgs; [
        bat
    ];

    programs.bat = {
        enable = true;
        config = {
            theme = "GitHub";
        };
    };
}
