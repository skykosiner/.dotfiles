{
    description = "Home Manager configuration of sky";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        sops-nix.url = "github:Mic92/sops-nix";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }@inputs:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations = {
            nixos-btw = lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs; };
                modules = [./hosts/nixos-btw/configuration.nix];
            };

            nix-btw = lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs; };
                modules = [./hosts/nix-btw/configuration.nix];
            };
        };

        homeConfigurations."sky" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];
        };
    };
}
