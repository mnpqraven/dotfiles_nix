{
  description = "Othi's system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "github:helix-editor/helix/master";
    hyprland.url = "github:hyprwm/Hyprland";
    nvf.url = "github:notashelf/nvf";
    swww.url = "github:LGFae/swww";
    yazi.url = "github:sxyazi/yazi";
    wallthi = {
      url = "github:mnpqraven/wallthi";
      # or local development
      # url = "path:/home/othi/Repos/private/wallthi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      utils = (import ./lib/utils.nix) { inherit inputs; };
    in
    with utils;
    {
      nixosConfigurations =
        { }
        // mkSystem {
          hostName = "pc";
          extraModules = [
            ./devices/dogshitasslogitechmouse.nix
          ];
        }
        // mkSystem { hostName = "pcremote"; }
        // mkSystem { hostName = "laptop"; }
        // mkSystem { hostName = "homelab"; };
    };
}
