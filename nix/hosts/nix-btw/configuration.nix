{ config, pkgs, ... }:

{
  imports = [ ../../configuration.nix ./hardware-configuration.nix ];

  networking = { hostName = "nix-btw"; };

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

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  systemd.services.enable-wowlan = {
    description = "Enable WoWLAN on wlp9s0";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart =
        "/run/current-system/sw/bin/iw phy0 wowlan enable magic-packet";
    };
  };
}
