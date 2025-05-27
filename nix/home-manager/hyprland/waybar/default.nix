{ pkgs, hostname, lib, ... }:

let
    laptop = (hostname == "nixos-btw");
    airconIcon = if (laptop) then "  " else " ";
in {
    # 
    home.packages = with pkgs; [
        waybar
    ];

    programs.waybar = {
        enable = true;
        style = ''
        * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: FontAwesome, "Berkely Mono";
            font-weight: bold;
            font-size: 12px;
        }

        window#waybar {
            /*border-radius: 10px;*/
            background-color: rgba(42, 47, 58, 0.9);
            color: #d9e0ee;
        }

        /*#workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
            box-shadow: inset 0 -3px #d9e0ee;
        }*/

        #workspaces button:nth-child(1) label {
            color: #8aadf4;
            margin: 0px 8px;
        }

        #workspaces button:nth-child(2) label {
            color: #ed8796;
            margin: 0px 8px;
        }

        #workspaces button:nth-child(3) label {
            color: #a6da95;
            margin: 0px 8px;
        }

        #workspaces button:nth-child(4) label {
            color: #c6a0f6;
            margin: 0px 8px;
        }

        #workspaces button:nth-child(5) label {
            color: #f4dbd6;
            margin: 0px 8px;
        }

        #workspaces button:nth-child(6) label {
            color: #f5a97f;
            margin: 0px 8px;
        }

        #workspaces button:nth-child(7) label {
            color: #8bd5ca;
            margin: 0px 8px;
        }

        #workspaces button:nth-child(8) label {
            color: #68b0d6;
            margin: 0px 8px;
        }

        #workspaces button:nth-child(9) label {
            color: #aab1d3;
            margin: 0px 8px;
        }

        #custom-dot {
            color: #6e738d;
            padding-left: 5px;
            padding-right: 5px;
        }

        #pulseaudio {
            color: #91d7e3;
            border-radius: 0px 5px 5px 0px;
            padding-left: 5px;
        }

        #network {
            color: #c6a0f6;
            padding-left: 5px;
        }

        #clock {
            color: #cad3f5;
            padding-left: 5px;
            padding-right: 5px;
        }

        #battery {
            padding-left: 5px;
        }

        #custom-linux {
            font-size: 15px;
            color: #F3BE75;
            /*background-color: #F3BE75;*/
            border-radius: 10px;
            /*padding-right: 5px;*/
            padding-left: 5px;
        }

        #custom-todoist {
            color: #DCA3A2;
        }

        #custom-aircon {
            color: #B5DEDB;
        }

        #custom-spotify {
            color: #20E5A4;
        }

        #custom-dnd {
            color: #9D4040;
        }
        '';
        settings = [
            {
                layer = "top";
                position = "bottom";
                height = 35;
                margin-top = 0;
                margin-left = 0;
                margin-bottom = 0;
                margin-right = 5;
                spacing = 0;
                modules-left = [
                    "custom/linux"
                    "custom/dot"
                    "custom/aircon"
                    "custom/dot"
                    "custom/spotify"
                    "custom/dot"
                    "custom/dnd"
                ];
                modules-center = [
                    "hyprland/workspaces"
                ];
                modules-right = lib.optionals laptop [
                    "battery"
                    "custom/dot"
                ] ++ [
                    "custom/todoist"
                    "custom/dot"
                    "pulseaudio"
                    "custom/dot"
                    "network"
                    "custom/dot"
                    "custom/time-tracking"
                    "custom/dot"
                    "clock"
                ];
                "custom/linux" = {
                    format = "";
                };
                "custom/dot" = {
                    format = "";
                    tooltip = false;
                };
                network = {
                    format-wifi = "󰒢 {essid}";
                    on-click = "ghostty -e nmtui";
                    on-click-right = "nm-connection-editor";
                    format-ethernet = " wired";
                    tooltip-format = "{essid} {signalStrength}%";
                    format-disconnected = "Network: Not Connected";
                };
                "hyprland/workspaces" = {
                    on-click = "activate";
                    format = "{icon}";
                    on-scroll-up = "hyprctl dispatch workspace e+1";
                    on-scroll-down = "hyprctl dispatch workspace e-1";
                    format-icons = {
                        "1" = "1";
                        "2" = "2";
                        "3" = "3";
                        "4" = "4";
                        "6" = "6";
                        "7" = "7";
                        "8" = "8";
                        "9" = "9";
                    };
                };
                clock = {
                    format = "<b>{:%I:%M %p }</b>";
                    tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
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
                    on-click = "ghostty -e pulsemixer";
                };
                "custom/todoist" = {
                    format = " {}";
                    interval =  60;
                    exec = "/home/sky/.local/bin/statusbar/sb-todoist";
                };
                "custom/aircon" = {
                    format = " ${airconIcon} {}";
                    interval = 90;
                    exec = "/home/sky/.local/bin/statusbar/sb-aircon";
                    signal = 9;
                };
                "custom/spotify" = {
                    format = "   {}";
                    interval = 1;
                    exec = "/home/sky/.local/bin/statusbar/sb-music";
                    signal = 10;
                };
                "custom/dnd" = {
                    format = " {}";
                    interval = 60;
                    exec = "/home/sky/.local/bin/statusbar/sb-dnd";
                    on-click = "dunstctl set-paused toggle";
                    signal = 10;
                };
                "custom/time-tracking" = {
                    format = " {}";
                    interval = 1;
                    exec = "/home/sky/.local/bin/statusbar/sb-time-tracking";
                };
            }
        ];
    };
}
