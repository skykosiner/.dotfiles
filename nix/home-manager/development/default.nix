{ pkgs, system, ... }:

let notArm = system != "aarch64-linux";
in {
  imports = [ ./neovim ./zsh ./tmux ./languages ./fzf ./bat ./ssh ];

  home.packages = with pkgs; (if notArm then [ wirelesstools webkitgtk_4_1 gjs ] else [ ]) ++ [
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
    # rustup
    rust-analyzer
    gopls
    shellcheck

    glib
    gdk-pixbuf
    libsoup_3
    pango
    gtk3
  ];

  programs.git = {
    enable = true;
    userName = "Sky Kosiner";
    userEmail = "sky@skykosiner.com";
  };

  home.sessionVariables = { NODE_ENV = "development"; };
}
