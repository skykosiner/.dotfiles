{ pkgs, ... }:

{
  home.packages = with pkgs; [ qtpass ];

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions
      (exts: with exts; [ pass-import pass-file pass-otp pass-update ]);
    settings = { PASSWORD_STORE_DIR = "$HOME/.password-store"; };
  };
}
