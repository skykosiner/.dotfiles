{
  pkgs,
  platform,
  config,
  ...
}:

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
    ./emacs
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

      python3Packages.tkinter

      inetutils
      websocat
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
      postgresql

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
      gore
      shellcheck

    ];

  programs.git = {
    enable = true;

    settings = {
      user.name = "Sky Kosiner";
      user.email = "sky@skykosiner.com";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    };

    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_rsa";
      signByDefault = true;
      format = "ssh";
    };
  };

  home.file.".ssh/allowed_signers".text = ''
    sky@skykosiner.com ${config.programs.git.signing.key}
  '';

  home.sessionVariables = {
    NODE_ENV = "development";
  };
}
