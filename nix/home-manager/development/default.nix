{ pkgs, ... }:

{
    imports = [
        ./neovim
        ./zsh
        ./tmux
        ./languages
        ./fzf
        ./bat
    ];

    home.packages = with pkgs; [
        ansible

        bun
        gjs

        inetutils
        wirelesstools
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
        webkitgtk_4_1
    ];

    programs.git = {
        enable = true;
        userName = "Sky Kosiner";
        userEmail = "sky@skykosiner.com";
    };

    home.sessionVariables = {
        NODE_ENV = "development";
    };
}
