{ pkgs, inputs, ... }:

{
    home.packages = with pkgs; [
        luajitPackages.luarocks
        luajit
        fd
        tree-sitter
    ];

    programs.neovim = {
        enable = true;
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        plugins = [
          pkgs.vimPlugins.nvim-treesitter
        ];
    };

    xdg.configFile = {
        "nvim" = {
            source = ../../../../nvim/.config/nvim;
        };
    };
}
