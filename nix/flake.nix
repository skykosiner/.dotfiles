{
    description = "Home Manager configuration of sky";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
                modules = [./hosts/nixos-btw/configuration.nix];
            };

            nix-btw = lib.nixosSystem {
                inherit system;
                modules = [./hosts/nix-btw/configuration.nix];
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
