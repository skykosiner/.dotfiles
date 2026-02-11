{ lib, config, pkgs, inputs, ... }:

let
  cifsOptions = [
    "credentials=/etc/smbcredentials"
    "iocharset=utf8"
    "vers=3.0"
    "file_mode=0777"
    "dir_mode=0777"
    "nounix"
    "nofail"
  ];

  homeDir = if pkgs.stdenv.isDarwin then "/Users/sky" else "/home/sky";
  berkeleyPath = /.
    + "${homeDir}/.dotfiles/private_stuff/berkeley-mono-regular.zip";
  TX-02Path = /. + "${homeDir}/.dotfiles/private_stuff/font/TX-02.zip";

  berkeley-mono =
    pkgs.callPackage ./packages/berkeley-mono.nix { fontPath = berkeleyPath; };
  TX-02 = pkgs.callPackage ./packages/TX-02.nix { fontPath = TX-02Path; };

  packetTracer = pkgs.ciscoPacketTracer8.override {
    packetTracerSource = ./pkgs/CiscoPacketTracer822_amd64_signed.deb;
  };
in {
  nix = {
    settings.warn-dirty = false;
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
    };
  };

  boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
  };

  networking = {
    hosts = { "127.0.0.1" = [ "chatgpt.com" "chat.openai.com" ]; };
    networkmanager.enable = true;
    wireguard.enable = true;

    firewall.allowedTCPPorts = [ 42069 5900 42068 38165 53317 ];

    wg-quick.interfaces = {
      wg0 = {
        autostart = false;
        address = [ "10.100.0.2/32" ];
        dns = [ "1.1.1.1" ];
        privateKeyFile = "/home/sky/.dotfiles/private_stuff/privateKey";

        peers = [{
          publicKey = "fwS4fgjfM+AUDCS1mwcZ9toAh9r8VuXyQ5CVshQTgXE=";
          endpoint = builtins.readFile
            "/home/sky/.dotfiles/private_stuff/endpoint_ip.txt";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
        }];
      };
    };

    wireless.networks."The Kosiner's wifi" = {
      ssid = "The Kosiner's wifi";
      psk = builtins.readFile
        "/home/sky/.dotfiles/private_stuff/wifi/home_wifi_password";
    };
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    zsh.enable = true;
    gnupg.agent.enable = true;
    ssh.startAgent = true;
    ydotool.enable = true;
  };

  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  services = {
    tailscale.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        extraLayouts.real-prog-dvorak = {
          description = "real-prog-dvoark";
          languages = [ "eng" ];
          symbolsFile = ./symbols/real-prog-dvorak;
        };
      };
    };

    davmail = {
      enable = true;
      config = {
        davmail.url = "https://outlook.office365.com/EWS/Exchange.asmx";
        davmail.mode = "O365Modern";
      };
    };

    openssh = {
      enable = true;
      settings = { X11Forwarding = true; };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    control-http-home = {
      enable = true;
      commands = [
        {
          name = "sleep";
          action = "systemctl suspend -i";
          url = "/sleep";
        }
        {
          name = "live";
          action = "/home/sky/.dotfiles/private_stuff/live";
          url = "/live";
        }
      ];
    };

    cloudflared.enable = true;
    udisks2.enable = true;
    usbmuxd.enable = true;
    displayManager.sddm.enable = true;
    printing.enable = true;
    #pulseaudio.enable = false;
    flatpak.enable = true;
    playerctld.enable = true;
    tumbler.enable = true;
    gvfs.enable = true;
  };

  security.rtkit.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    virtualbox.host.enableExtensionPack = true;
    permittedInsecurePackages = [ "ciscoPacketTracer8-8.2.2" ];
  };

  environment.systemPackages = with pkgs; [
    cron
    wget
    home-manager
    file
    gnupg
    isync
    htop
    pinentry-gtk2
    acpi
    blueman
    neomutt
    mutt-wizard
    alsa-utils
    udiskie
    btop
    firefox
    wireguard-tools
    docker
    cifs-utils
    dunst
    stow
    cloudflared
    openrazer-daemon
    polychromatic
    font-manager
    acpilight
    brightnessctl
    davmail
    sops
    libimobiledevice
    ifuse
    iw
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    inter
    ubuntu-classic
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.victor-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.go-mono
    nerd-fonts.comic-shanns-mono
    berkeley-mono
    TX-02
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    xone.enable = true;

    keyboard = {
      zsa.enable = true;
      qmk.enable = true;
    };

    openrazer.enable = true;
  };

  fileSystems."/mnt/server" = {
    device = "//10.0.0.36/Files";
    fsType = "cifs";
    options = cifsOptions;
  };

  fileSystems."/mnt/ssd" = {
    device = "//10.0.0.36/T7";
    fsType = "cifs";
    options = cifsOptions;
  };

  fileSystems."/mnt/RANDY" = {
    device = "//10.0.0.36/RANDY";
    fsType = "cifs";
    options = cifsOptions;
  };

  virtualisation = {
    virtualbox.host.enable = true;
    docker.enable = true;
  };

  users = {
    users.sky = {
      isNormalUser = true;
      description = "sky";
      extraGroups = [ "networkmanager" "wheel" "docker" "openrazer" "dialout" ];
      shell = pkgs.zsh;
      hashedPassword =
        "$6$p011SB1zy3NpqFjq$rdHjOi.GD.w/IUss5H9wmYJGckOQsAEVerQH6NKH6g9n8eG3XQJ1iIkKU4KE/pSwaIH69Gsg7Pa07j.8ErxUA0";
    };

    extraGroups.vboxusers.members = [ "sky" ];
  };

  security.sudo.extraRules = [{
    users = [ "sky" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      packettracer8 = {
        executable = "${packetTracer}/bin/packettracer8";
        extraArgs = [ "--noprofile" "--net=none" ];
      };
    };
  };

  console.keyMap = "uk";
  system.stateVersion = "24.05";
}
