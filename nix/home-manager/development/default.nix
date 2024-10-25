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
