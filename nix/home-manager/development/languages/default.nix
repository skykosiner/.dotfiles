{ pkgs, ... }:

{
    home.packages = with pkgs; [
        python3
        python312Packages.pip
        nodejs
        go
        cargo
        clang-tools
    ];
}
