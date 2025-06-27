{ inputs, config, ... }:
let
  users = builtins.listToAttrs (
    builtins.map (name: {
      inherit name;
      value = import ../users/${name}/hm-entrypoint.nix;
    }) config.features.users
  );
in
{
  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = true;
    inherit users;
    extraSpecialArgs = { inherit inputs; };
  };
}
