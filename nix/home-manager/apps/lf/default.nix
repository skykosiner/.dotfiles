{ pkgs, ... }:

{
  home.packages = with pkgs; [ lf xdragon ueberzugpp ];
  # TODO: Move my lf config to home manger at some point
  xdg.configFile = { "lf" = { source = ../../../../lf/.config/lf; }; };
}
