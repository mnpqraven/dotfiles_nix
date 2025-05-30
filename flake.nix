{
  description = "Othi's system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    helix.url = "github:helix-editor/helix/master";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:jas-singhfsu/hyprpanel";
    nvf.url = "github:notashelf/nvf";
    swww.url = "github:LGFae/swww";
    yazi.url = "github:sxyazi/yazi";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
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
    in
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
        // mkSystem { hostName = "laptop"; };
    };
}
