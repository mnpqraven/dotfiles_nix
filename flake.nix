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
      hmParams.home-manager = {
        useGlobalPkgs = false;
        useUserPackages = true;
        users.othi = import ./users/othi/home.nix;
        extraSpecialArgs = { inherit inputs; };
      };

      mkSystem =
        {
          platform ? "x86_64-linux",
          extraModules ? [ ],
          hostName,
          userEntrypoint,
        }:
        {
          ${hostName} = nixpkgs.lib.nixosSystem {
            system = platform;
            specialArgs = { inherit inputs; };
            modules = [
              ./base
              userEntrypoint
              ./users/othi/nixos.nix
              ./users/othi/services.nix
              home-manager.nixosModules.home-manager
              hmParams
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
          userEntrypoint = ./hosts/pc;
        }
        // mkSystem {
          hostName = "pcremote";
          userEntrypoint = ./hosts/pcremote;
        }
        // mkSystem {
          hostName = "laptop";
          userEntrypoint = ./hosts/laptop;
        };
    };
}
