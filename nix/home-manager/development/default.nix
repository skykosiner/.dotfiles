{ pkgs, system, ... }:

let isDarwin = system == "aarch64-darwin";
in {
  imports = [ ./neovim ./zsh ./tmux ./languages ./fzf ./bat ./ssh ];

  home.packages = with pkgs;
    (if !isDarwin then [
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
    ] else
      [ ]) ++ [
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
        # rustup
        rust-analyzer
        gopls
        shellcheck
      ];

  programs.git = {
    enable = true;
    userName = "Sky Kosiner";
    userEmail = "sky@skykosiner.com";
  };

  home.sessionVariables = { NODE_ENV = "development"; };
}
