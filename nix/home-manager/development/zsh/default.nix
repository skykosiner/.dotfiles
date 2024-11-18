{ pkgs, config, ... }:

let inherit (config.lib.file) mkOutOfStoreSymlink;

in {
    home.packages = with pkgs; [
        zsh
        zsh-syntax-highlighting
        zsh-autosuggestions
    ];


    home.file = {
        ".zshrc".source = mkOutOfStoreSymlink "/home/sky/.dotfiles/zsh/.zshrc";
        ".zshenv".source = mkOutOfStoreSymlink "/home/sky/.dotfiles/zsh/.zshenv";
    };

    xdg.configFile.personal.source = mkOutOfStoreSymlink "/home/sky/.dotfiles/shell/.config/personal/";
}
