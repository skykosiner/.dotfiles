{ pkgs, hostname, inputs, ... }:

{
    home.packages = with pkgs; [
        inputs.ghostty.packages.x86_64-linux.default
    ];

    home.file.".config/ghostty/config".text = ''
        font-family = Berkeley Mono
        background = 111111
        cursor-style = block
        cursor-style-blink = false
        theme = rose-pine
        confirm-close-surface = false

        shell-integration-features = no-cursor,no-sudo,title
    '';
}
