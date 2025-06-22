{ config, pkgs, ... }:

{
  imports = [ ../../configuration.nix ./hardware-configuration.nix ];

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
    graphics = { enable = true; };
  };

  services.cron = {
    enable = true;
    systemCronJobs = [ "0 10 * * 1 /home/sky/.local/bin/updateServers" ];
  };
}
