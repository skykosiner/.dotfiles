{ pkgs, hostname, ... }:
let
  fontsize = if (hostname == "nix-btw") then "16" else "10";
in {
    home.packages = with pkgs; [
        fuzzel
        bemoji
    ];
    programs.fuzzel = {
        enable = true;
        settings = {
            colors.background = "3D4455DD";
            main = {
                font = "Berkeley Mono:size=${fontsize}";

        # homeConfigurations."sky" = home-manager.lib.homeManagerConfiguration {
        #     inherit pkgs;
        #     modules = [ ./home-manager ];
        # };
                lines = 16;
                terminal = "alacritty";
                tabs = 4;
                width = 69;
                horizontal-pad = 32;
                vertical-pad = 32;
                inner-pad = 32;
            };
            border = {
                width = 5;
                radius = 8;
            };
        };
    };
}
