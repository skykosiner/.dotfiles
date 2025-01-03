{ pkgs, hostname, inputs, ... }:

{
    home.packages = with pkgs; [
        pkgs.ghostty
    ];

    home.file.".config/ghostty/config".text = ''
        font-family = "TX-02"
        font-style = "Medium"
        font-style-italic = "Medium Oblique"
        font-style-bold = "ExtraBold"
        font-style-bold-italic = "ExtraBold Oblique"
        font-size = 16

        # SYNTHETIC FONT STYLE GENERATION
        font-synthetic-style = false

        # DISABLE FONT LIGATURES: -calt -liga -dlig
        font-feature = -calt

        background = 111111
        cursor-style = block
        cursor-style-blink = false
        theme = nord
        confirm-close-surface = false

        # Remove the top bar
        gtk-titlebar = false

        shell-integration-features = no-cursor,no-sudo,title
    '';
}
