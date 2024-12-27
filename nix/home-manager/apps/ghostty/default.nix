{ pkgs, hostname, ... }:

{
    home.packages = with pkgs; [
        ghostty.packages.x86_64-linux.default
    ];
}
