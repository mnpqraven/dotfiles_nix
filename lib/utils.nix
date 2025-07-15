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
          ./features.nix
          ../base
          ../services
          ../hosts/${hostName}
          inputs.home-manager.nixosModules.home-manager
        ] ++ extraModules;
      };
    };

}
