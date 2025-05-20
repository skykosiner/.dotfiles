{
  description = "Home Manager configuration of sky";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-doom-emacs-unstraightened.url =
      "github:marienz/nix-doom-emacs-unstraightened";

    zen-browser.url = "github:MarceColl/zen-browser-flake";

    asus-wmi-screenpad = {
      url = "github:MatthewCash/asus-wmi-screenpad-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, asus-wmi-screenpad, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      stateVersion = "24.05";
      helper = import ./lib { inherit inputs outputs stateVersion; };
    in {
      nixosConfigurations = {
        nixos-btw = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixos-btw/configuration.nix
            {
              _module.args = {
                inputs = { inherit asus-wmi-screenpad; };
                system = system;
              };
            }
          ];
        };

        nix-btw = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/nix-btw/configuration.nix ];
        };
      };

      homeConfigurations = {
        "sky@nixos-btw" = helper.mkHome {
          hostname = "nixos-btw";
          username = "sky";
        };
        "sky@nix-btw" = helper.mkHome {
          hostname = "nix-btw";
          username = "sky";
        };
      };
    };
}
