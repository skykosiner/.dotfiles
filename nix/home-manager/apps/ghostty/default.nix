{ pkgs, hostname, inputs, ... }:

{
    home.packages = with pkgs; [
        inputs.ghostty.packages.x86_64-linux.default
    ];
}
