{ pkgs, ... }:

{
    home.packages = with pkgs; [
        fastfetch
    ];

    programs.fastfetch = {
        enable = true;
        settings = {
            display.separator = " ";
            modules = [
                "break"
                {
                    type = "host";
                    key = " PC";
                    keyColor = "green";
                }
                {
                    type = "cpu";
                    key = "│ ├";
                    showPeCoreCount = true;
                    keyColor = "green";
                }
                {
                    type = "gpu";
                    key = "│ ├󰍛";
                    keyColor = "green";
                }
                {
                    type = "memory";
                    key = "│ ├󰍛";
                    keyColor = "green";
                }
                {
                    type = "disk";
                    key = "│ ├";
                    keyColor = "green";
                }
                "break"
                {
                    type = "os";
                    key = "OS";
                    keyColor = "yellow";
                }
                {
                    type = "kernel";
                    key = "│ ├";
                    keyColor = "yellow";
                }
                {
                    type = "packages";
                    key = "│ ├󰏖";
                    keyColor = "yellow";
                }
                {
                    type = "shell";
                    key = "│ ├";
                    keyColor = "yellow";
                }
                {
                    type = "de";
                    key = " DE";
                    keyColor = "yellow";
                }
                {
                    type = "lm";
                    key = "│ ├";
                    keyColor = "yellow";
                }
                {
                    type = "wm";
                    key = "│ ├";
                    keyColor = "yellow";
                }
                "break"
                {
                    type = "command";
                    key = "OS Age ";
                    keyColor = "magenta";
                    text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
                }
                {
                    type = "uptime";
                    key = "Uptime ";
                    keyColor = "magenta";
                }
                "break"
            ];
        };
    };
}
