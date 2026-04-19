{ config, pkgs, lib, hostname, inputs, platform, ... }:

let
  apps = import ./apps { inherit pkgs platform; };
  development = import ./development { inherit pkgs platform config; };

in {
  imports = [ apps development ];

  home = {
    username = "sky";
    homeDirectory = "/Users/sky";
    stateVersion = "24.05";
    sessionVariables = { EDITOR = "nvim"; };

    packages = with pkgs; [
      highlight
      lolcat
      figlet
      cowsay
      gh-markdown-preview
      ares-cli
      groff
      pfetch
      killall
      ffmpegthumbnailer
      pandoc
      poppler-utils
      python312Packages.docx2txt
      exiftool
      catdoc
      msmtp
      mediainfo
      lynx
      atool
      pulsemixer
      wol
      inputs.alga.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs = { home-manager.enable = true; };
}
