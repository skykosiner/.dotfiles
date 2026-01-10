{ lib, config, pkgs, inputs, ... }:
let
  homeDir = if pkgs.stdenv.isDarwin then "/Users/sky" else "/home/sky";
  berkeleyPath = /.
    + "${homeDir}/.dotfiles/private_stuff/berkeley-mono-regular.zip";
  TX-02Path = /. + "${homeDir}/.dotfiles/private_stuff/font/TX-02.zip";

  berkeley-mono =
    pkgs.callPackage ./packages/berkeley-mono.nix { fontPath = berkeleyPath; };
  TX-02 = pkgs.callPackage ./packages/TX-02.nix { fontPath = TX-02Path; };

in {
  nix.enable = false;
  nix.settings.experimental-features = "nix-command flakes";
  system = {
    primaryUser = "sky";
    stateVersion = 6;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;

      # 120, 90, 60, 30, 12, 6, 2
      KeyRepeat = 2;

      # 120, 94, 68, 35, 25, 15
      InitialKeyRepeat = 15;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.sound.beep.feedback" = 0;
    };
    dock = {
      autohide = true;
      show-recents = false;
      launchanim = true;
      mouse-over-hilite-stack = true;
      orientation = "left";
      tilesize = 28;
      autohide-time-modifier = 0.3;
      expose-animation-duration = 0.3;
      magnification = true;
      largesize = 50;
    };
    finder = { _FXShowPosixPathInTitle = false; };
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;
  homebrew = {
    enable = true;

    taps = [ ];
    brews = [ "cowsay" "htop" ];
    casks = [ "handbrake-app" "gimp" "calibre" "todoist" ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.sky = {
    name = "sky";
    home = "/Users/sky";
  };

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

}
