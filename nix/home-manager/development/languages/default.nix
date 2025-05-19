{ pkgs, ... }:

{
    home.packages = with pkgs; [
        python3
        python312Packages.pip
        nodePackages.vscode-langservers-extracted
        nil
        nixfmt
        nodejs
        cargo
        rustc
        go
        clang-tools
        templ
        sqls
    ];
}
