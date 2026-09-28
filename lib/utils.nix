{ inputs }:
{
  mkSystem =
    {
      system ? "x86_64-linux",
      extraModules ? [ ],
      hostName,
    }:
    {
      ${hostName} = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          (_: {
            networking = { inherit hostName; };
          })
          ./features.nix
          ../base
          ../services
          ../hosts/${hostName}
          ../users/othi/nixos.nix
          inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.home-manager
        ]
        ++ extraModules;
      };
    };
  # without any base modules, mainly for debugging purposes
  mkBaseless =
    {
      system ? "x86_64-linux",
      extraModules ? [ ],
      hostName,
    }:
    {
      ${hostName} = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          (_: {
            networking = { inherit hostName; };
          })
          ./features.nix
          ../services
          ../hosts/${hostName}
          ../users/othi/nixos.nix
          inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.home-manager
        ]
        ++ extraModules;
      };
    };
}
