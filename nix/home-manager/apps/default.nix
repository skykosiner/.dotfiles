{ pkgs, ... }:

{
    imports = [
        ./alacritty
        ./starship
        ./zathura
        ./lf
        ./obs
        ./fastfetch
    ];

    home.packages = with pkgs; [
        beeper
        davinci-resolve
        teams-for-linux
        kitty
        spotify
        spotify-cli-linux
        xfce.xfconf
        xfce.thunar
        libreoffice
        mpv
        obsidian
        brave
        sxiv
        qbittorrent
        bitwarden-desktop
        gimp
    ];
}
