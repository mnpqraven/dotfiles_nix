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
          entrypoint,
        }:
        {
          ${hostName} = nixpkgs.lib.nixosSystem {
            system = platform;
            specialArgs = { inherit inputs; };
            modules = [
              ./base
              entrypoint
              ./users/othi/nixos.nix
              ./users/othi/services.nix
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
          entrypoint = ./hosts/pc;
        }
        // mkSystem {
          hostName = "pcremote";
          entrypoint = ./hosts/pcremote;
        }
        // mkSystem {
          hostName = "laptop";
          entrypoint = ./hosts/laptop;
        };
    };
}
