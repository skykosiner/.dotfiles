{
  pkgs,
  inputs,
  config,
  platform,
  ...
}:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  isDarwin = platform == "aarch64-darwin";
  neovimPath = if isDarwin then "/Users/sky/.dotfiles/nvim/" else "/home/sky/.dotfiles/nvim/";

in
{
  home.packages = with pkgs; [
    luajitPackages.luarocks
    luajit
    fd
    tree-sitter
  ];

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    plugins = [ pkgs.vimPlugins.nvim-treesitter ];
    initLua = "";
  };

  # xdg.configFile.nvim.source = mkOutOfStoreSymlink neovimPath;
  xdg.configFile = {
    "nvim/init.lua".source = mkOutOfStoreSymlink "${neovimPath}/init.lua";
    "nvim/lua".source = mkOutOfStoreSymlink "${neovimPath}/lua";
    "nvim/after".source = mkOutOfStoreSymlink "${neovimPath}/after";
    "nvim/spell".source = mkOutOfStoreSymlink "${neovimPath}/spell";
    "nvim/lazy-lock.json".source = mkOutOfStoreSymlink "${neovimPath}/lazy-lock.json";
  };
}
