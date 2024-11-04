{ pkgs, ... }:

# TOOD: Move setting up obs configs and evyrthing here at some point
{
  home.packages = with pkgs; [
      pass
  ];

  {
      programs.pass = {
          enable = true;
          extensions = with pkgs; [
              pass-import
                  pass-file
                  pass-otp
                  pass-update
          ];
      };
  }
}
