{
  description = "Home Manager configuration of sky";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-doom-emacs-unstraightened.url =
      "github:marienz/nix-doom-emacs-unstraightened";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    asus-wmi-screenpad = {
      url = "github:MatthewCash/asus-wmi-screenpad-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    control-http-home = {
      url = "github:skykosiner/control-http-home-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alga = {
      url = "github:Tenzer/alga";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, asus-wmi-screenpad, apple-silicon
    , zen-browser, sops-nix, control-http-home, alga, nix-darwin, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      stateVersion = "24.05";
      helper = import ./lib { inherit self inputs outputs stateVersion; };
    in {
      nixosConfigurations = {
        nixos-btw = lib.nixosSystem {
          modules = [
            inputs.control-http-home.nixosModules.default
            ./hosts/nixos-btw/configuration.nix
            sops-nix.nixosModules.sops
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
            sops-nix.nixosModules.sops
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
          modules = [
            inputs.control-http-home.nixosModules.default
            ./hosts/nix-btw/configuration.nix
            sops-nix.nixosModules.sops
            {
              _module.args = {
                # inputs = { inherit asus-wmi-screenpad; };
                system = "x86_64-linux";
              };
            }
          ];
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

      darwinConfigurations."skys-MacBook-Air" = nix-darwin.lib.darwinSystem {
          modules = [
		  ./mac.nix
		  home-manager.darwinModules.home-manager
		  {
		    home-manager.useGlobalPkgs = true;
		    home-manager.useUserPackages = true;
		    home-manager.users.sky = import ./home-manager/mac.nix;

		    # Optionally, use home-manager.extraSpecialArgs to pass
		    # arguments to home.nix
		    home-manager.extraSpecialArgs = {
		      inherit inputs;
		      system = "aarch64-linux";
		      hostname = "skys-MacBook-Air";
		    };
		  }
	  ];
      };
    };
}
