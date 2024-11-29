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

        cmake
        ninja
        gcc
        gnumake

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
