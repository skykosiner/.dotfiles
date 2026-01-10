{ pkgs, config, system, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  notArm = system != "aarch64-linux";
  zshrcPath = if notArm then
    "/home/sky/.dotfiles/zsh/.zshrc"
  else
    "/Users/sky/.dotfiles/zsh/.zshrc";
  zshenvPath = if notArm then
    "/home/sky/.dotfiles/zsh/.zshenv"
  else
    "/Users/sky/.dotfiles/zsh/.zshenv";
  personalShellPath = if notArm then
    "/Users/sky/.dotfiles/shell/.config/personal/"
  else
    "/Users/sky/.dotfiles/shell/.config/personal/";

in {
  home.packages = with pkgs; [
    zsh
    zsh-syntax-highlighting
    zsh-autosuggestions
  ];

  # programs.zsh = {
  #   enable = true;
  #   syntaxHighlighting.enable = true;
  #   autosuggestion.enable = true;
  # };

  home.file = {
    ".zshrc".source = mkOutOfStoreSymlink zshrcPath;
    ".zshenv".source = mkOutOfStoreSymlink zshenvPath;
  };

  xdg.configFile.personal.source = mkOutOfStoreSymlink personalShellPath;
}
