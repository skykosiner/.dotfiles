{ pkgs, ... }:

{
    home.packages = with pkgs; [
        python3
        python312Packages.pip
        nodejs
        cargo
        rustc
        go
        clang-tools
    ];
}
