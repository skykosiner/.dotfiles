{ config, lib, pkgs, apple-silicon, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ../../configuration.nix
    ./hardware-configuration.nix
    ./apple-silicon-support
    # apple-silicon.nixosModules.default # or the correct path
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # nixpkgs.overlays = [ apple-silicon.overlays.apple-silicon-overlay ];

  hardware.asahi = {
    enable = true;
    useExperimentalGPUDriver = true;
  };

  networking.hostName = "mac-btw";
}

