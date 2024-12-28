{ pkgs, hostname, inputs, ... }:

{
    home.packages = with pkgs; [
        inputs.ghostty.packages.x86_64-linux.default
    ];

    home.file.".config/ghostty/config".text = ''
        font-family = Berkeley Mono
        font-size = 16
        background = 111111
        cursor-style = block
        cursor-style-blink = false
        theme = tokyonight
        confirm-close-surface = false

        # Remove the top bar
        gtk-titlebar = false

        shell-integration-features = no-cursor,no-sudo,title
    '';
}
