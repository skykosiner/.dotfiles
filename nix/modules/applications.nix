{ pkgs, ... }:

{
  home.packages = with pkgs; [
      # Thunar needs this in order to save configs
      xfce.xfconf

      libreoffice
      mpv
      zathura
      xfce.thunar
      spotify
      spotify-cli-linux
      obsidian
      brave
      sxiv
      bitwarden-desktop
      gimp
  ];

  programs.zathura = {
      enable = true;
      extraConfig = ''
        set sandbox none
        set statusbar-h-padding 0
        set statusbar-v-padding 0
        set page-padding 1
        set selection-clipboard clipboard
        map u scroll half-up
        map d scroll half-down
        map D toggle_page_mode
        map r reload
        map R rotate
        map K zoom in
        map J zoom out
        map i recolor
        map p print
        map g goto top
      '';
  };
}
