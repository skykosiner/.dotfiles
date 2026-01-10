{ config, pkgs, lib, hostname, inputs, system, ... }:

let
   apps = import ./apps { inherit pkgs system; };
  development = import ./development { inherit pkgs system; };
	notArm = system != "aarch64-linux";

in {
  imports =
    [ apps development ];

  home = {
    username = "sky";
    homeDirectory = "/Users/sky";
    stateVersion = "24.05";
    sessionVariables = { EDITOR = "nvim"; };

    packages = with pkgs; if notArm then [ playerctl networkmanagerapplet  flat-remix-gtk] else [ ]  ++ [
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
      inputs.alga.packages.${pkgs.system}.default
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;
  };
}
