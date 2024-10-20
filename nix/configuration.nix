{ config, pkgs, ... }:

{
    nix = {
        package = pkgs.nixFlakes;
        extraOptions = ''
            experimental-features = nix-command flakes
            '';
    };

    imports =
        [ ./hardware-configuration.nix ];

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos-btw";
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
    # services.displayManager.sddm.enable = true;

    services.xserver = {
        xkb.extraLayouts.real-prog-dvorak = {
            description = "real-prog-dvoark";
            languages = [ "eng" ];
            symbolsFile = /etc/nixos/symbols/real-prog-dvorak;
        };
    };

    services.xserver.xkb = {
        layout = "us";
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
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
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
        lua
        luajit
        vim
        brave
        fzf
        neofetch
        neovim
        ripgrep
        cmake
        home-manager
        ninja
        pass
        wl-clipboard
        spotify
        file
        gnupg
        obsidian
        eza
        htop
        tmux
        acpi
        gh
        neomutt
        mutt-wizard
        tree-sitter
        sxiv
        bitwarden-desktop
        btop
        alacritty
        kitty
        zsh
        stow
        gimp
        cargo
        starship
        zoxide
        go
        lf
    ];

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        font-awesome
    ];

    services.openssh.enable = true;

    system.stateVersion = "24.05";  # Keep this as your first install version
}
