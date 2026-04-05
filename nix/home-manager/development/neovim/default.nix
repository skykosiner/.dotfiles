{ pkgs, inputs, config, system, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  isDarwin = system == "aarch64-darwin";
  neovimPath = if isDarwin then
    "/Users/sky/.dotfiles/nvim/"
  else
    "/home/sky/.dotfiles/nvim/";

in {
  home.packages = with pkgs; [ luajitPackages.luarocks luajit fd tree-sitter ];

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = [ pkgs.vimPlugins.nvim-treesitter ];
  };

  xdg.configFile.nvim.source = mkOutOfStoreSymlink neovimPath;
}
