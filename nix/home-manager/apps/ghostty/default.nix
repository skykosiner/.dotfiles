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

        cursor-style = block
        cursor-style-blink = false
        theme = light:nord-light, dark:nord-custom
        confirm-close-surface = false

        # Remove the top bar
        gtk-titlebar = false

        shell-integration-features = no-cursor,no-sudo,title
    '';

    home.file.".config/ghostty/themes/nord-custom".text = ''
        palette = 0=#3b4252
        palette = 1=#bf616a
        palette = 2=#a3be8c
        palette = 3=#ebcb8b
        palette = 4=#81a1c1
        palette = 5=#b48ead
        palette = 6=#88c0d0
        palette = 7=#e5e9f0
        palette = 8=#4c566a
        palette = 9=#bf616a
        palette = 10=#a3be8c
        palette = 11=#ebcb8b
        palette = 12=#81a1c1
        palette = 13=#b48ead
        palette = 14=#8fbcbb
        palette = 15=#eceff4
        background = 111111
        foreground = d8dee9
        cursor-color = eceff4
        selection-background = eceff4
        selection-foreground = 4c566a
    '';
}
