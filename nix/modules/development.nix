{ pkgs, ... }:

{
    home.packages = with pkgs; [
        alacritty
        kitty
        starship

        # Language stuff
        python3
        python312Packages.pip
        nodejs
        go
        cargo
        clang-tools

        # Make stuff
        cmake
        ninja
        gcc
        gnumake

        # Tools
        unzip
        ripgrep
        vim
        neovim
        tree-sitter
        eza
        gh
        tokei
        tldr
        git
        zsh
        zsh-syntax-highlighting
        zsh-autosuggestions
        tmux
        docker
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
            window.opacity = 0.9;
            # colors.primary.background = "#000000";
            font.size = 16;
            font.normal.family = "JetBrainsMono Nerd Font";
        };
    };

    programs.neovim.plugins = [
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];

    # You can also set up other configurations specific to development
    # For example, environment variables or tools
    home.sessionVariables = {
        NODE_ENV = "development";
    };
}
