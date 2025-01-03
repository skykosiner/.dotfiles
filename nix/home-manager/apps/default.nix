{ pkgs, ... }:

{
    imports = [
        ./alacritty
        ./ghostty
        ./starship
        ./zathura
        ./lf
        ./obs
        ./fastfetch
        ./pass
    ];

    home.packages = with pkgs; [
        calibre
        lunar-client
        yt-dlp
        cmatrix
        lazygit
        newsboat
        beeper
        # davinci-resolve
        wlsunset
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
