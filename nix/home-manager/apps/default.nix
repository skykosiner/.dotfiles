{ pkgs, hostname, ... }:

let notMac = hostname != "mac-btw";
in {
  imports = (if notMac then [ ./obs ] else [ ])
    ++ [ ./alacritty ./ghostty ./starship ./zathura ./lf ./fastfetch ./pass ];

  home.packages = with pkgs;
    (if notMac then [ discord beeper spotify google-chrome ] else [ ]) ++ [
      nextcloud-client
      trash-cli
      timeshift
      vesktop
      sqlitebrowser
      chatterino2
      calibre
      yt-dlp
      cmatrix
      lazygit
      newsboat
      # davinci-resolve
      wlsunset
      thunderbird
      teams-for-linux
      kitty
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
