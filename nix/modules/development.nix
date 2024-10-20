{ pkgs, ... }:

{
    home.packages = with pkgs; [
        alacritty
        kitty
        starship

        # Language stuff
        python3
        nodejs
        go
        cargo

        # Make stuff
        cmake
        ninja
        gcc
        gnumake

        # Tools
        ripgrep
        vim
        neovim
        tree-sitter
        eza
        gh
        git
        zsh
        tmux
        fzf
        bat
        zoxide
    ];

    programs.git = {
        enable = true;
        userName = "Sky Kosiner";
        userEmail = "sky@skykosiner.com";
    };


    programs.alacritty = {
        enable = true;
        settings = {
            window.opacity = 0.8;
            colors.primary.background = "#000000";
            font.size = 16;
            font.normal.family = "JetBrainsMono Nerd Font";
        };
    };

    # You can also set up other configurations specific to development
    # For example, environment variables or tools
    home.sessionVariables = {
        NODE_ENV = "development";
    };
}
