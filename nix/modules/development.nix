{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty

    # Language stuff
    python3
    nodejs
    go

    # Make stuff
    cmake
    ninja
    gcc
    gnumake

    # Tools
    git
    zsh
    tmux
    fzf
  ];

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
