{ pkgs, inputs, config, system, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  notArm = system != "aarch64-linux";
  neovimPath = if notArm then
    "/home/sky/.dotfiles/nvim/"
  else
    "/Users/sky/.dotfiles/nvim/";

in {
  home.packages = with pkgs; [ luajitPackages.luarocks luajit fd tree-sitter ];

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = [ pkgs.vimPlugins.nvim-treesitter ];
  };

  xdg.configFile.nvim.source = mkOutOfStoreSymlink neovimPath;
}
