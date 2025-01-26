{ config, pkgs, ... }:

{
    imports = [
        ../../configuration.nix
            ./hardware-configuration.nix
    ];

    networking.hostName = "nix-btw";


    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
        nvidia = {
            package = config.boot.kernelPackages.nvidiaPackages.stable;
            modesetting.enable = true;
            open = true;
            powerManagement.enable = true;
            nvidiaSettings = true;
        };
        graphics = {
            enable = true;
        };
    };
}
