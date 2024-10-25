{ pkgs, ... }:

{
    home.packages = with pkgs; [
        zsh
        zsh-syntax-highlighting
        zsh-autosuggestions
    ];

    home.file = {
        ".zshrc".source = ../../../../zsh/.zshrc;
        ".zshenv".source = ../../../../zsh/.zshenv;
    };
    xdg.configFile = {
        "personal" = {
            source = ../../../../shell/.config/personal;
        };
    };
}
