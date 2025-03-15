{ pkgs, ... }:

# TOOD: Move setting up obs configs and evyrthing here at some point
{
  home.packages = with pkgs; [
      # obs-studio
      usbmuxd
      ffmpeg
      droidcam
  ];

  programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
          obs-pipewire-audio-capture
      ];
   };
}
