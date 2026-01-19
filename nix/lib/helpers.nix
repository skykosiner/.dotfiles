{
  inputs,
  outputs,
  stateVersion,
  ...
}:
{
  # Helper function for generating home-manager configs
  mkHome =
    {
      hostname,
      username ? "sky",
      platform ? "x86_64-linux",
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          hostname
          platform
          username
          stateVersion
          ;
        system = platform;
      };
      modules = [
        inputs.nix-doom-emacs-unstraightened.hmModule
        ../home-manager
      ];
    };
}
