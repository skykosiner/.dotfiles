{ pkgs, ... }:

{
    home.packages = with pkgs; [
        luajitPackages.luarocks
        luajit
        neovim
        tree-sitter
    ];

    programs.neovim.plugins = [
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];

    xdg.configFile = {
        "nvim" = {
            source = ../../../../nvim/.config/nvim;
        };
    };
}
