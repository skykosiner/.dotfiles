{
  description = "Home Manager configuration of sky";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-doom-emacs-unstraightened.url =
      "github:marienz/nix-doom-emacs-unstraightened";

    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { self, nixpkgs, home-manager, asus-wmi-screenpad, apple-silicon
    , ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      stateVersion = "24.05";
      helper = import ./lib { inherit inputs outputs stateVersion; };
    in {
      nixosConfigurations = {
        nixos-btw = lib.nixosSystem {
          modules = [
            ./hosts/nixos-btw/configuration.nix
            {
              _module.args = {
                inputs = { inherit asus-wmi-screenpad; };
                system = "x86_64-linux";
              };
            }
          ];
        };

        mac-btw = lib.nixosSystem {
          modules = [
            ./hosts/mac-btw/configuration.nix
            {
              _module.args = {
                inputs = { inherit apple-silicon; };
                system = "aarch64-linux";
              };
            }
          ];
        };

        nix-btw = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/nix-btw/configuration.nix ];
        };
      };

      homeConfigurations = {
        "sky@nixos-btw" = helper.mkHome {
          hostname = "nixos-btw";
          username = "sky";
        };
        "sky@mac-btw" = helper.mkHome {
          hostname = "mac-btw";
          username = "sky";
          platform = "aarch64-linux";
        };
        "sky@nix-btw" = helper.mkHome {
          hostname = "nix-btw";
          username = "sky";
        };
      };
    };
}
