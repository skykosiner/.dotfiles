{ pkgs, ... }:

{
    imports = [
        ./alacritty
        ./starship
        ./zathura
        ./lf
        ./obs
        ./fastfetch
        ./pass
    ];

    home.packages = with pkgs; [
        newsboat
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
        nsxiv
        qbittorrent
        bitwarden-desktop
        gimp
        pavucontrol
    ];
}
