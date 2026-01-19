{ pkgs, system, ... }:

let notMac = system != "aarch64-linux";
in {
  imports = (if notMac then [ ./obs ./ghostty ] else [ ])
    ++ [ ./alacritty ./starship ./zathura ./lf ./fastfetch ./pass ./mpv ];

  home.packages = with pkgs;
    (if notMac then [
      discord
      beeper
      spotify
      google-chrome
      lutris
      dolphin-emu
      vlc
      xfce.xfconf
      xfce.thunar
      pika-backup
      ktailctl
      todoist-electron
      makemkv
      lunar-client
      calibre
      davinci-resolve
      wlsunset
      spotify-cli-linux
      libreoffice
      gimp
      pavucontrol
      shotwell
      koreader
      mupen64plus
    ] else
      [ ]) ++ [
        ryubing
        prismlauncher
        moonlight-qt
        trash-cli
        vesktop
        sqlitebrowser
        chatterino2
        yt-dlp
        cmatrix
        lazygit
        newsboat
        clipse
        thunderbird
        teams-for-linux
        kitty
        obsidian
        brave
        nsxiv
        qbittorrent
        bitwarden-desktop
        audacity
        realvnc-vnc-viewer
        google-chrome
        localsend
      ];
}
