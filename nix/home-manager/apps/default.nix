{ pkgs, hostname, ... }:

let notMac = hostname != "mac-btw";
in {
  imports = (if notMac then [ ./obs ] else [ ]) ++ [
    ./alacritty
    ./ghostty
    ./starship
    ./zathura
    ./lf
    ./fastfetch
    ./pass
    ./mpv
  ];

  home.packages = with pkgs;
    (if notMac then [ discord beeper spotify google-chrome ] else [ ]) ++ [
      ktailctl
      moonlight-qt
      todoist-electron
      makemkv
      lunar-client
      plasma5Packages.kdeconnect-kde
      trash-cli
      pika-backup
      vesktop
      sqlitebrowser
      chatterino2
      calibre
      yt-dlp
      cmatrix
      lazygit
      newsboat
      davinci-resolve
      clipse
      wlsunset
      thunderbird
      teams-for-linux
      kitty
      spotify-cli-linux
      xfce.xfconf
      xfce.thunar
      libreoffice
      obsidian
      brave
      nsxiv
      qbittorrent
      bitwarden-desktop
      gimp
      pavucontrol
      shotwell
      audacity
      realvnc-vnc-viewer
    ];
}
