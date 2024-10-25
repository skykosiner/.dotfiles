{
    description = "Home Manager configuration of sky";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
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

        homeConfigurations."sky" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home-manager ];
        };
    };
}
