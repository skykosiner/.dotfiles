{ pkgs, ... }:

# TOOD: Move setting up obs configs and evyrthing here at some point
{
  home.packages = with pkgs; [
      obs-studio
      usbmuxd
      droidcam
  ];
}
