{
  nixpkgs,
  home-manager,
  ...
}@inputs:
{
  mkSystem =
    {
      platform ? "x86_64-linux",
      extraModules ? [ ],
      hostName,
    }:
    {
      ${hostName} = nixpkgs.lib.nixosSystem {
        system = platform;
        specialArgs = { inherit inputs; };
        modules = [
          ./base
          ./services
          ./features.nix
          ./hosts/${hostName}
          ./users/othi/nixos.nix
          home-manager.nixosModules.home-manager
        ] ++ extraModules;
      };
    };

}
