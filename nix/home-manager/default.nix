{
  config,
  pkgs,
  lib,
  hostname,
  inputs,
  platform,
  ...
}:

let
  apps = import ./apps { inherit pkgs platform; };
  theme = import ./theme {
    inherit
      pkgs
      lib
      hostname
      config
      ;
  };
  hyprland = import ./hyprland { inherit pkgs hostname; };
  development = import ./development { inherit pkgs platform; };

in
{
  imports = [
    apps
    theme
    hyprland
    development
    inputs.zen-browser.homeModules.beta
  ];

  home = {
    username = "sky";
    homeDirectory = "/home/sky";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
      GTK_THEME = "Nordic";
    };

    packages = with pkgs; [
      wineWow64Packages.full
      android-tools
      mailsy
      highlight
      lolcat
      figlet
      cowsay
      gh-markdown-preview
      ares-cli
      playerctl
      groff
      pfetch
      killall
      udiskie
      ffmpegthumbnailer
      pandoc
      poppler-utils
      python312Packages.docx2txt
      python312Packages.ffmpeg-progress-yield
      exiftool
      networkmanagerapplet
      flat-remix-gtk
      neovim-remote
      catdoc
      msmtp
      mediainfo
      lynx
      atool
      pulsemixer
      wol
      inputs.alga.packages.${pkgs.stdenv.hostPlatform.system}.default
      usbutils
      hyfetch
      hyprsunset
      terminaltexteffects
      jp2a
      showmethekey
    ];
  };

  xdg.dataHome = "/home/sky/.local/share/";

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "ciscoPacketTracer8-8.2.2" ];
  };

  programs = {
    zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
    };

    home-manager.enable = true;
  };

  services.udiskie = {
    enable = true;
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
    };
  };

  xdg = {
    configFile."fontconfig/conf.d/10-beeper-emoji.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <match target="pattern">
          <test qual="any" name="family"><string>serif</string></test>
          <edit name="family" mode="append" binding="weak">
            <string>Noto Color Emoji</string>
          </edit>
        </match>
        <match target="pattern">
          <test qual="any" name="family"><string>sans-serif</string></test>
          <edit name="family" mode="append" binding="weak">
            <string>Noto Color Emoji</string>
          </edit>
        </match>
        <match target="pattern">
          <test qual="any" name="family"><string>monospace</string></test>
          <edit name="family" mode="append" binding="weak">
            <string>Noto Color Emoji</string>
          </edit>
        </match>
      </fontconfig>
    '';
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/jpeg" = [ "nsxiv.desktop" ];
        "image/png" = [ "nsxiv.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "inode/directory" = [ "thunar.desktop" ];
        "x-scheme-handler/http" = [ "brave-browser.desktop" ];
        "x-scheme-handler/https" = [ "brave-browser.desktop" ];
        "x-scheme-handler/mailto" = [ "neomutt.desktop" ];
      };
    };
    enable = true;
  };
}
