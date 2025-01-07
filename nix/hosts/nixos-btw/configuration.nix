{ config, pkgs, ... }:

{
    imports =
        [
            ../../configuration.nix
            ./hardware-configuration.nix
        ];

    networking.hostName = "nixos-btw";

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            intel-compute-runtime
        ];
    };
}
