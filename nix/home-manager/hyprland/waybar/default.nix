{ pkgs, hostname, lib, ... }:

let
    laptop = (hostname == "nixos-btw");
in {
    home.packages = with pkgs; [
        waybar
    ];

    programs.waybar = {
        enable = true;
        style = ''
        * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: FontAwesome, "BerkleyMono Nerd Font";
            /*font-weight: 500;*/
            font-size: 12px;
        }

        .modules-right {
            margin-right: 0.5rem;
        }

        #workspaces button.active {
            background: #64727D;
            border-bottom: 3px solid white;
        }

        #workspaces button.urgent {
            background-color: #eb4d4b;
        }

        window#waybar {
            /*border-radius: 10rem;*/
            background-color: rgba(14, 1, 0, 0.7);
            /*border-bottom: 3px solid rgba(110, 108, 126, 1);*/
            color: #d9e0ee;
        }

        #workspaces button {
            padding: 0 9px;
            background-color: transparent;
            color: #d9e0ee;
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -3px transparent;
            /* Avoid rounded borders under each workspace name */
            border: none;
            border-radius: 0;
        }

        /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
        #workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
            box-shadow: inset 0 -3px #d9e0ee;
        }
        '';
        settings = [
            {
                layer = "bottom";
                position = "top";
                spacing = 10;
                modules-left = [
                    "hyprland/workspaces"
                ];
                modules-center = [
                    "hyprland/window"
                ];
                modules-right = lib.optionals laptop [
                    "battery"
                ] ++ [
                    "custom/aircon"
                    "pulseaudio"
                    "custom/todoist"
                    "custom/clock"
                    "tray"
                ];
                 tray = {
                    spacing = 10;
                };
                "custom/clock" = {
                    format = "{}";
                    interval = 60;
                    exec = "/home/sky/.local/bin/statusbar/sb-timeDateClean";
                };
                battery = {
                    states = {
                        good = 95;
                        warning = 30;
                        critical = 15;
                    };
                    format = "{icon} {capacity}%";
                    format-full = "{icon} {capacity}%";
                    format-charging = "  {capacity}%";
                    format-plugged = " {capacity}%";
                    format-alt = "{time} {icon}";
                    format-icons = [
                        "  "
                        "  "
                        "  "
                        "  "
                        "  "
                    ];
                };
                pulseaudio = {
                    scroll-step = 5;
                    format = "{icon} {volume}%";
                    format-icons = [
                        " "
                        " "
                        " "
                    ];
                    on-click = "alacritty -e pulsemixer";
                };
                "custom/todoist" = {
                    format = "{}";
                    interval =  60;
                    exec = "/home/sky/.local/bin/statusbar/sb-todoist";
                };
                "custom/aircon" = {
                    format = "{}";
                    interval = 90;
                    exec = "/home/sky/.local/bin/statusbar/sb-aircon";
                    signal = 9;
                };
            }
        ];
    };
}
