{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    python3
    python312Packages.pip
    nodePackages.vscode-langservers-extracted
    nixd
    nixfmt-classic
    nodejs
    cargo
    rustc
    go
    clang-tools
    templ
    sqls
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
