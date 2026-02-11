{ config, pkgs, lib, hostname, inputs, system, ... }:

let
  apps = import ./apps { inherit pkgs system; };
  theme = import ./theme { inherit pkgs lib hostname; };
  hyprland = import ./hyprland { inherit pkgs hostname; };
  development = import ./development { inherit pkgs system; };

in {
  imports =
    [ apps theme hyprland development inputs.zen-browser.homeModules.beta ];

  home = {
    username = "sky";
    homeDirectory = "/home/sky";
    stateVersion = "24.05";
    sessionVariables = { EDITOR = "nvim"; };

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
      catdoc
      msmtp
      mediainfo
      lynx
      atool
      pulsemixer
      wol
      inputs.alga.packages.${pkgs.system}.default
      usbutils
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

  services.udiskie = { enable = true; };

  xdg = {
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
