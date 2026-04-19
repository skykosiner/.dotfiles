{ pkgs, config, platform, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  isDarwin = platform == "aarch64-darwin";

  zshrcPath = if isDarwin then
    "/Users/sky/.dotfiles/zsh/.zshrc"
  else
    "/home/sky/.dotfiles/zsh/.zshrc";

  zshenvPath = if isDarwin then
    "/Users/sky/.dotfiles/zsh/.zshenv"
  else
    "/home/sky/.dotfiles/zsh/.zshenv";

  personalShellPath = if isDarwin then
    "/Users/sky/.dotfiles/shell/.config/personal/"
  else
    "/home/sky/.dotfiles/shell/.config/personal/";

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
