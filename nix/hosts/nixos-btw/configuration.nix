{ config, pkgs, ... }:

{
    imports =
        [
            ../../configuration.nix
            ./hardware-configuration.nix
        ];

    networking.hostName = "nixos-btw";

    hardware.opengl = {
        enable = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
            intel-compute-runtime
        ];
    };
}
