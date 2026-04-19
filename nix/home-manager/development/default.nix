{ pkgs, platform, ... }:

let
  isDarwin = platform == "aarch64-darwin";
in
{
  imports = [
    ./neovim
    ./zsh
    ./tmux
    ./languages
    ./fzf
    ./bat
    ./ssh
  ];

  home.packages =
    with pkgs;
    (
      if !isDarwin then
        [
          wirelesstools
          webkitgtk_4_1
          gjs
          glib
          gdk-pixbuf
          libsoup_3
          pango
          gtk3
          burpsuite
          bettercap
          aircrack-ng
          arduino-ide
        ]
      else
        [ ]
    )
    ++ [
      htmlq
      bruno
      bruno-cli

      nmap

      ansible
      hugo

      bun

      inetutils
      unzip
      ripgrep
      jq
      vim
      imagemagick
      eza
      gh
      tokei
      tldr
      git
      docker
      zoxide
      openssl
      pkg-config

      sqlite

      bc
      arp-scan

      cmake
      ninja
      gcc
      gnumake

      basedpyright
      lua-language-server
      vtsls
      rust-analyzer
      gopls
      shellcheck
    ];

  programs.git = {
    enable = true;

    settings = {
      user.name = "Sky Kosiner";
      user.email = "sky@skykosiner.com";
    };

    signing = {
      key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqfi+Dwvi61z79/cJnzPtQu6+7+ngakO0K0x4iX5hplyxmZG76zsVmowl75qy6oJbud7bsTOvyiCMM9OR77/lhGcUu8OINF6SKGqHY0MA2SB46Eq+0b/sfRA2jerzwvTaNco3aErE9+SZzfF/4iUct2RRF7ajWXO+iQMoXnSm5MuxBnXXWfRbwsWiuss7SCtj0zCcSl/HIkNPFe8Am6idBtPnFVMkW1MtOtPdDofIGkxj/4nF9qFJpQOtEHPwEVjgzyXG4NI7yKArl2hNYMnah1hbMesaxxaMLE3j0aRIBVoUXgbmI/JaFNhjBTsb4t1BoDU6zdVh9WbM1qAonRxr/ytoinb7hUFJKSbzc9is1+nPqpYodq7Xoh+QvwLY3BU3N43YEFyBsb5pJcmaEKl/MRfSzxuUUP9LvWJr6UmBx+gBK2yESCIVGHUNWakQSmoLmQz6d++IkqQfbwDvXz8NqV66pZeV7EqQ6gqATfkrY+O+lLzWaLhUGSzZwIMX4Fh0= sky@arch-btw";
      signByDefault = true;
      format = "ssh";
    };
  };

  home.sessionVariables = {
    NODE_ENV = "development";
  };
}
