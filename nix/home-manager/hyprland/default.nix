{ pkgs, hostname, ... }:

let isLaptop = hostname == "nix-btw";
in {
  imports = [ ./rofi ./fuzzel ./waybar ];

  home.packages = with pkgs; [
    swww
    mpvpaper
    wtype
    hyprland
    grim
    hyprcursor
    slurp
    libnotify
    hyprlock
    swayidle
    wl-clipboard
    networkmanagerapplet
    hyprpicker
    wayvnc
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$menu" = "fuzzel";
      bind = (if isLaptop then [
        "$mainMod SHIFT, equal, workspace, 1"
        "$mainMod, bracketleft, workspace, 2"
        "$mainMod SHIFT, bracketleft, workspace, 3"
        "$mainMod SHIFT, 9, workspace, 4"
        "$mainMod SHIFT, 7, workspace, 5"
        "$mainMod, equal, workspace, 6"
        "$mainMod SHIFT, 0, workspace, 7"
        "$mainMod SHIFT, bracketright, workspace, 8"
        "$mainMod, bracketright, workspace, 9"
        "$mainMod SHIFT, 8, workspace, 10"

        "$mainMod, 1, movetoworkspacesilent, 1"
        "$mainMod, 2, movetoworkspacesilent, 2"
        "$mainMod, 3, movetoworkspacesilent, 3"
        "$mainMod, 4, movetoworkspacesilent, 4"
        "$mainMod, 5, movetoworkspacesilent, 5"
        "$mainMod, 6, movetoworkspacesilent, 6"
        "$mainMod, 7, movetoworkspacesilent, 7"
        "$mainMod, 8, movetoworkspacesilent, 8"
        "$mainMod, 9, movetoworkspacesilent, 9"
        "$mainMod, 0, movetoworkspacesilent, 10"
      ] else [
        "$mainMod, plus, workspace, 1"
        "$mainMod, bracketleft, workspace, 2"
        "$mainMod, braceleft, workspace, 3"
        "$mainMod, parenleft, workspace, 4"
        "$mainMod, ampersand, workspace, 5"
        "$mainMod, equal, workspace, 6"
        "$mainMod, parenright, workspace, 7"
        "$mainMod, braceright, workspace, 8"
        "$mainMod, bracketright, workspace, 9"
        "$mainMod, asterisk, workspace, 10"

        "$mainMod SHIFT, plus, movetoworkspacesilent, 1"
        "$mainMod SHIFT, bracketleft, movetoworkspacesilent, 2"
        "$mainMod SHIFT, braceleft, movetoworkspacesilent, 3"
        "$mainMod SHIFT, parenleft, movetoworkspacesilent, 4"
        "$mainMod SHIFT, ampersand, movetoworkspacesilent, 5"
        "$mainMod SHIFT, equal, movetoworkspacesilent, 6"
        "$mainMod SHIFT, parenright, movetoworkspacesilent, 7"
        "$mainMod SHIFT, braceright, movetoworkspacesilent, 8"
        "$mainMod SHIFT, bracketright, movetoworkspacesilent, 9"
        "$mainMod SHIFT, asterisk, movetoworkspacesilent, 10"
      ]) ++ [
        "$mainMod, F1, exec, $HOME/.local/bin/nightshift"
        ", F6, togglespecialworkspace, spotify"
        ", F7, togglespecialworkspace, message"
        "SHIFT, F7, togglespecialworkspace, hidden"
        "ALT, space, exec, $HOME/.local/bin/quick-add-task"
        ''
          $mainMod SHIFT, s, exec, grim -g "$(slurp)" ~/Pictures/Captures/"$(date +%d%m%y%s).png"''
        ''$mainMod SHIFT, n, exec, grim -g "$(slurp)" - | wl-copy''
        "$mainMod SHIFT, P, exec, hyprpicker -a | wl-copy"
        "$mainMod, w, exec, nsxiv -t $HOME/.dotfiles/backgrounds/"
        "$mainMod SHIFT, B, exec, pkill waybar || waybar"
        "$mainMod, comma, movecurrentworkspacetomonitor, +1"
        "$mainMod, return, exec, $terminal"
        "$mainMod SHIFT, C, killactive,"
        "$mainMod SHIFT, period, exit,"
        "$mainMod SHIFT, T, togglefloating,"
        "$mainMod, h, exec, ~/.local/bin/move_or_group left"
        "$mainMod, j, exec, ~/.local/bin/move_or_group down"
        "$mainMod, k, exec, ~/.local/bin/move_or_group up"
        "$mainMod, l, exec, ~/.local/bin/move_or_group right"
        "$mainMod SHIFT, h, movewindoworgroup, l"
        "$mainMod SHIFT, l, movewindoworgroup, r"
        "$mainMod SHIFT, k, movewindoworgroup, u"
        "$mainMod SHIFT, j, movewindoworgroup, d"
        "$mainMod, F, fullscreen, 0"
        "$mainMod, t, togglegroup"

        "$mainMod, o, exec, $terminal -e /home/sky/.local/bin/lfub"
        "$mainMod SHIFT, w, exec, brave"

        "$mainMod, Space, togglesplit"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        "Alt SHIFT, l, resizeactive, 60 0"
        "Alt SHIFT, h, resizeactive, -60 0"
        "Alt SHIFT, k, resizeactive, 0 -60"
        "Alt SHIFT, j, resizeactive, 0 60"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      input = {
        kb_layout = if isLaptop then "us" else "real-prog-dvorak";
        kb_options = if isLaptop then "" else "caps:swapescape";
        kb_variant = "";
        kb_model = "";
        kb_rules = "";

        repeat_delay = 300;
        repeat_rate = 50;

        follow_mouse = 1;
        sensitivity = 0;

        touchpad = { natural_scroll = false; };
      };

      monitor = if hostname == "nixos-btw" then [
        "eDP-1,1920x1080@60,0x0,1"
        "DP-1,1920x515@60,0x1080,1"
      ] else if hostname == "nix-btw" then [
        # "DP-2,1920x1080@120,0x0,1,transform,3"
        # "DP-3,2560x1440@170,1080x0,1"
        "DP-2,1920x1080@120,0x0,1"
        "DP-3,2560x1440@170,1920x0,1"
        # "DP-2,1920x1080@120,0x0,1"
        # "HDMI-A-1,1920x1080,3640x0,1"
      ] else
        [
          # Fallback (safe default)
          ",preferred,auto,auto"
        ];
      misc = {
        enable_swallow = true;
        swallow_regex = "^(Alacritty)$";
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        background_color = "0x111111";
      };

      device = [{
        name = "kinesis-corporation-form-keyboard";
        kb_layout = "real-prog-dvorak";
      }];

      env = [
        "XCURSOR_SIZE,16"
        "HYPRCURSOR_SIZE,16"
        "XCURSOR_THEME,Bibata-Modern-Classic"
      ];

      "exec-once" = [
        "hyprctl setcursor Bibata-Modern-Classic 16"
        "swww init"
        "swww restore"
        "swww-daemon"
        "waybar"
      ];

      exec = (if isLaptop then [ "~/.local/bin/screenLock" ] else [ ]);

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "rgba(ff0000ee)";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      group = {
        groupbar = {
          "col.active" = "rgba(000000aa)";
          "col.inactive" = "rgba(595959aa)";
        };
        "col.border_active" = "rgba(ff0000ee)";
        "col.border_inactive" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = false;
          size = 2;
          ignore_opacity = true;
          passes = 3;
          noise = 1.0e-2;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = false;
        animation = [
          "windows, 1, 3, default, popin 5%"
          "workspaces, 1, 3, default, slidefade 5%"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = { mfact = 0.5; };

      gestures = { workspace_swipe = true; };

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
        "tile, class:Nsxiv"
        "tile, class:Xdg-desktop-portal-gtk"
        "workspace 10, class:obsidian"
        "workspace 7, class:Microsoft Teams - Preview"

         "workspace special:spotify, class:Spotify"
        # "opacity 0.90 0.90, class:Spotify"

         "workspace special:message, class:Beeper"
         # "opacity 0.90 0.90, class:Beeper"

        # "opacity 0.90 0.90, initialTitle:Snapchat"
        # "workspace special:message, initialTitle:Snapchat"

        "workspace special:message, class:vesktop"
        "noanim, class:^ueberzugpp"
        "float, title:^toggl$"
        "size 900x900, title:^toggl$"
        "move center, title:^toggl$"

        #"bordersize 0, floating:0, onworkspace:w[tv1]"
        #"rounding 0, floating:0, onworkspace:w[tv1]"
        #"bordersize 0, floating:0, onworkspace:f[1]"
        #"rounding 0, floating:0, onworkspace:f[1]"
      ];
    };
    extraConfig = ''
              # workspace = w[tv1], gapsout:0, gapsin:0
              # workspace = f[1], gapsout:0, gapsin:0

              bind = SUPER, M, submap, appsubmaps
              submap = appsubmaps

              bind = ,n,exec,$HOMe
              bind = ,n,submap,reset

              bind = ,e,exec,thunderbird -mail
              bind = ,e,submap,reset

              bind = ,c,exec,thunderbird -calendar
              bind = ,c,submap,reset

              bind = ,f,exec, thunar
              bind = ,f,submap,reset

              bind = ,h,exec, $terminal -e htop
              bind = ,h,submap,reset

              bind = ,n,exec, $terminal -e nmtui
              bind = ,n,submap,reset

              bind = ,p,exec, $terminal -e pulsemixer
              bind = ,p,submap,reset

              bind=,escape,submap,reset
              submap = reset

      # Lights keychords
              bind = ALT, L, submap, lightsubmaps
              submap = lightsubmaps

              bind = ,l,exec,/home/sky/.local/go/bin/lights ceiling
              bind = ,l,submap,reset

              bind = ,s,exec,/home/sky/.local/go/bin/lights studio
              bind = ,s,submap,reset

              bind = ,r,exec,/home/sky/.local/go/bin/lights others
              bind = ,r,submap,reset

              bind = ,a,exec,/home/sky/.local/go/bin/lights all
              bind = ,a,submap,reset

              bind = ,p,exec,/home/sky/.local/bin/light-percent
              bind = ,p,submap,reset

              bind = ,t,exec,/home/sky/.local/bin/light-temp
              bind = ,t,submap,reset

              bind=,escape,submap,reset
              submap = reset

      # Aircon keycohrds
              bind = SUPER, a, submap, airconsubmaps
              submap = airconsubmaps

              bind = ,o,exec,/home/sky/.local/go/bin/aircon toggle
              bind = ,o,submap,reset

              bind = ,c,exec,/home/sky/.local/bin/airconControl -cold
              bind = ,c,submap,reset

              bind = ,h,exec,/home/sky/.local/bin/airconControl -heat
              bind = ,h,submap,reset

              bind = ,n,exec,/home/sky/.local/bin/airconControl -set-temp
              bind = ,n,submap,reset

              bind = ,f,exec,/home/sky/.local/bin/airconControl -set-fan
              bind = ,f,submap,reset

              bind=,escape,submap,reset
              submap = reset

      # Sptoify control
              bind = SUPER, s, submap, spotifysubmaps
              submap = spotifysubmaps

              bind = ,p,exec,/home/sky/.local/bin/spotify-control -togglePlay
              bind = ,p,submap,reset

              bind = ,period,exec,/home/sky/.local/bin/spotify-control -next
              bind = ,period,submap,reset

              bind = ,comma,exec,/home/sky/.local/bin/spotify-control -prev
              bind = ,comma,submap,reset

              bind=,escape,submap,reset
              submap = reset

      # Launechr stuff
              bind = SUPER, p, submap, launchersubmaps
              submap = launchersubmaps

              bind = ,p,exec,$menu
              bind = ,p,submap,reset

              bind = SHIFT,e,exec,export BEMOJI_PICKER_CMD="fuzzel --dmenu --width 48" && bemoji
              bind = SHIFT,e,submap,reset

              bind = ,w,exec,fuzzel --dmenu --lines 0 --placeholder "Type your search" | sed 's/^/"&/g;s/$/"/g' | xargs -I {} brave --new-window "https://google.com/search?q={}"
              bind = ,w,submap,reset

              bind = ,s,exec,$HOME/.local/bin/snipets
              bind = ,s,submap,reset

              bind = ,v,exec,$HOME/.local/bin/VMs
              bind = ,v,submap,reset

              bind = ,t,exec,$HOME/.local/bin/togglNew saved
              bind = ,t,submap,reset

              bind = ,n,exec,$HOME/.local/bin/togglNew
              bind = ,n,submap,reset

              bind=,escape,submap,reset
              submap = reset

              monitor = HEADLESS-2,disable
    '';
  };
}
