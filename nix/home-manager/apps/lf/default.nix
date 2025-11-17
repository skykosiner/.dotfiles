{ pkgs, ... }:

{
  home.packages = with pkgs; [ lf dragon-drop ueberzugpp ];
  # TODO: Move my lf config to home manger at some point
  xdg.configFile = { "lf" = { source = ../../../../lf/.config/lf; }; };
}
