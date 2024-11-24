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

    boot = {
        kernelModules = [ "v4l2loopback" ];
        extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };

    networking.networkmanager.enable = true;

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

    virtualisation.docker.enable = true;

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
        cron
        cronie
        wget
        kanata
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
        udiskie
        btop
        firefox
        wireguard-tools
        docker
        cifs-utils
        dunst
        stow
        cloudflared
        font-manager
        acpilight
        brightnessctl
        davmail
    ];

    services.davmail = {
        enable = true;
        config = {
            davmail.url = "https://outlook.office365.com/EWS/Exchange.asmx";
            davmail.mode = "O365Modern";
        };
    };


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

    hardware.keyboard.zsa.enable = true;
    hardware.keyboard.qmk.enable = true;

    services.udisks2.enable = true;

    services.openssh= {
        enable = true;
        forwardX11 = true;
    };

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

    # services.kanata = {
    #     enable = true;
    #     keyboards = {
    #         extraDefCfg = "process-unmapped-keys yes";
    #         devices = [ ];
    #         config = {
    #             defsrc = "caps a o e u h t n s";
    #             defvar = {
    #                 "tap-time" = 150;
    #                 "hold-time" = 200;
    #             };
    #             defalias = {
    #                 caps = "tap-hold 100 100 esc lctl";
    #                 a = "tap-hold $tap-time $hold-time a lsft";
    #                 o = "tap-hold $tap-time $hold-time o lctl";
    #                 e = "tap-hold $tap-time $hold-time e lalt";
    #                 u = "tap-hold $tap-time $hold-time u lmet";
    #                 h = "tap-hold $tap-time $hold-time h rmet";
    #                 t = "tap-hold $tap-time $hold-time t ralt";
    #                 n = "tap-hold $tap-time $hold-time n rctl";
    #                 s = "tap-hold $tap-time $hold-time s rsft";
                # };
                # deflayer = {
                    # base = "@caps @a  @o  @e  @u  @h  @t  @n  @s";
                # };
            # };
        # };
    # };


  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          "/dev/input/event21"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           caps a s d f j k l ;
          )
          (defvar
           tap-time 150
           hold-time 200
          )
          (defalias
           caps (tap-hold 100 100 esc lctl)
           a (tap-hold $tap-time $hold-time a lsft)
           s (tap-hold $tap-time $hold-time s lctl)
           d (tap-hold $tap-time $hold-time d lalt)
           f (tap-hold $tap-time $hold-time f lmet)
           j (tap-hold $tap-time $hold-time j rmet)
           k (tap-hold $tap-time $hold-time k ralt)
           l (tap-hold $tap-time $hold-time l rctl)
           ; (tap-hold $tap-time $hold-time ; rsft)
          )

          (deflayer base
           @caps @a  @s  @d  @f  @j  @k  @l  @;
          )
        '';
      };
    };
  };
}
