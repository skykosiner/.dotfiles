{ config, pkgs, inputs, ... }:

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

    wg_ip = builtins.readFile "../private_stuff/endpoint_ip.txt";
    berkeley-mono = pkgs.callPackage ./packages/berkeley-mono.nix { inherit pkgs; };
in {
    nix = {
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

    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/London";

    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
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

    services.xserver.enable = true;
    programs.hyprland.enable = true;
    services.displayManager.sddm.enable = true;

    services.xserver = {
        xkb = {
            layout = "us";
            extraLayouts.real-prog-dvorak = {
                description = "real-prog-dvoark";
                languages = [ "eng" ];
                symbolsFile = ./symbols/real-prog-dvorak;
            };
        };
    };

    console.keyMap = "uk";

    services.printing.enable = true;

    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    users.users.sky = {
        isNormalUser = true;
        description = "sky";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        shell = pkgs.zsh;
        hashedPassword = "$6$p011SB1zy3NpqFjq$rdHjOi.GD.w/IUss5H9wmYJGckOQsAEVerQH6NKH6g9n8eG3XQJ1iIkKU4KE/pSwaIH69Gsg7Pa07j.8ErxUA0";
    };

    security.sudo.extraRules = [
        {
            users = [ "sky" ];
            commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
        }
    ];

    programs.zsh.enable = true;

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        wget
        home-manager
        pass
        file
        gnupg
        isync
        htop
        pinentry-gtk2
        acpi
        blueman
        neomutt
        mutt-wizard
        udiskie
        btop
        firefox
        wireguard-tools
        docker
        cifs-utils
        dunst
        stow
        cloudflared
        acpilight
        brightnessctl
    ];

    programs.gnupg.agent.enable = true;

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        inter
        ubuntu_font_family
        noto-fonts-emoji
        font-awesome
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
        berkeley-mono
    ];

    networking.wireguard.enable = true;
    networking.wg-quick.interfaces = {
        wg0 = {
            address = [ "10.132.18.7/24"];
            dns = [ "10.132.18.1"];
            privateKeyFile = "/home/sky/.dotfiles/private_stuff/privateKey";

            peers = [
                {
                    publicKey = "9MAJnKepYwy2WSis4BHbIANfPoam7+1V30R40GxGVW0=";
                    presharedKeyFile = "/home/sky/.dotfiles/private_stuff/presharedKey";
                    endpoint = builtins.readFile "/home/sky/.dotfiles/private_stuff/endpoint_ip.txt";
                    allowedIPs = [ "0.0.0.0/0" "::/0" ];
                }
            ];
        };
    };

    services.cloudflared = {
        enable = true;
    };

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    services.udisks2.enable = true;

    services.openssh.enable = true;
    system.stateVersion = "24.05";  # Keep this as your first install version

    fileSystems."/mnt/server" = {
        device = "//10.0.0.36/Files";
        fsType = "cifs";
        options = cifsOptions;
    };

    fileSystems."/mnt/ssd" = {
        device = "//10.0.0.36/T7";
        fsType = "cifs";
        options =  cifsOptions;
    };
}
