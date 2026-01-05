{ pkgs, ... }:

# TOOD: Move setting up obs configs and evyrthing here at some point
{
  home.packages = with pkgs; [ usbmuxd ffmpeg droidcam ];

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override { cudaSupport = true; };
    plugins = with pkgs.obs-studio-plugins; [ obs-pipewire-audio-capture ];
  };
}
