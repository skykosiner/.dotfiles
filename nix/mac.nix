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
    brews = [ "cowsay" "htop" "pass" "neovim-remote" "cloudflared" ];
    casks = [ "handbrake-app" "gimp" "calibre" "todoist-app" "raycast" ];
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

  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        outer.left = 0;
        outer.bottom = 0;
        outer.top = 0;
        outer.right = 0;
      };
      mode.main.binding = {
        alt-j = "focus left";
        alt-c = "focus down";
        alt-k = "focus up";
        alt-p = "focus right";

        alt-shift-j = "move left";
        alt-shift-c = "move down";
        alt-shift-k = "move up";
        alt-shift-p = "move right";

        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";

        alt-enter =
          "exec-and-forget open -n /etc/profiles/per-user/sky/bin/alacritty";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-0 = "workspace 0";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
        alt-shift-0 = "move-node-to-workspace 0";
      };
    };
  };

  # system.activationScripts.applications.text = lib.mkForce ""
  #   echo "Setting up /Applications/Nix Apps" >&2
  #   appsSrc="/etc/profiles/per-user/sky/bin"
  #   baseDir="/Applications/Nix Apps"
  #   mkdir -p "$baseDir"
  #   ${pkgs.rsync}/bin/rsync --archive --checksum --chmod=-w --copy-unsafe-links --delete "$appsSrc" "$baseDir"
  # "";
}
