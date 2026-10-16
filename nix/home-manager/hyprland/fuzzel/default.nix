{ pkgs, hostname, ... }:
let
  fontsize = if (hostname == "nix-btw") then "16" else "10";
in
{
  home.packages = with pkgs; [
    fuzzel
    bemoji
  ];
  programs.fuzzel = {
    enable = true;
    settings = {
      colors.background = "1D2537FF";
      main = {
        font = "GoMono Nerd Font Mono:size=${fontsize}";

        # homeConfigurations."sky" = home-manager.lib.homeManagerConfiguration {
        #     inherit pkgs;
        #     modules = [ ./home-manager ];
        # };
        anchor = "top-left";
        lines = 3;
        terminal = "alacritty";
        tabs = 4;
        width = 20;
        horizontal-pad = 32;
        vertical-pad = 32;
        inner-pad = 32;
      };
      border = {
        width = 0;
        radius = 0;
      };
    };
  };
}
