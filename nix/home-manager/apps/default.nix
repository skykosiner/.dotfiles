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
        nextcloud-client
        trash-cli
        steam
        todoist-electron
        timeshift
        vesktop
        discord
        sqlitebrowser
        chatterino2
        calibre
        lunar-client
        yt-dlp
        cmatrix
        lazygit
        newsboat
        beeper
        # davinci-resolve
        wlsunset
        thunderbird
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
        google-chrome
        nsxiv
        qbittorrent
        bitwarden-desktop
        gimp
        pavucontrol
    ];
}
