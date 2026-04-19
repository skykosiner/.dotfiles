{ pkgs, platform, ... }:

let isDarwin = platform == "aarch64-darwin";
in {

  imports = [
    ./obs
    ./ghostty
    ./pass
    ./alacritty
    ./starship
    ./zathura
    ./lf
    ./fastfetch
    ./mpv
  ];

  home.packages = with pkgs;
    (if !isDarwin then [
      discord
      beeper
      spotify
      google-chrome
      lutris
      dolphin-emu
      vlc
      xfconf
      thunar
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
      yubioath-flutter
      quickgui
      newsboat
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
        browsh
        #(ciscoPacketTracer8.override {
        #  packetTracerSource = ./pkgs/CiscoPacketTracer822_amd64_signed.deb;
        #})
      ];

  # programs.sm64ex = {
  #   enable = true;
  #   baserom = "/home/sky/Documents/baserom.us.z64";
  #
  #   settings = {
  #     fullscreen = true;
  #     window_w = 3840;
  #     window_h = 2160;
  #     texture_filtering = 1; # Linear filtering for HD textures
  #     skip_intro = 1;
  #   };
  # };
}
