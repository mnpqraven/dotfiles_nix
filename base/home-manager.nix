{ inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = true;
    users.othi = import ../users/othi/home.nix;
    extraSpecialArgs = { inherit inputs; };
  };
}
