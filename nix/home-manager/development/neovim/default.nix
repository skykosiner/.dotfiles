{ pkgs, inputs, config, ... }:

let inherit (config.lib.file) mkOutOfStoreSymlink;

in {
  home.packages = with pkgs; [ luajitPackages.luarocks luajit fd tree-sitter ];

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = [ pkgs.vimPlugins.nvim-treesitter ];
  };

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/sky/.dotfiles/nvim/";
}
