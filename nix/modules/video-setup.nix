{ pkgs, ... }:

{
  home.packages = with pkgs; [
      obs-studio
      usbmuxd
      droidcam
  ];
}
