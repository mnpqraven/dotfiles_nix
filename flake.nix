{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    swww.url = "github:LGFae/swww";
    helix.url = "github:helix-editor/helix/master";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs.inputs = inputs;
          modules = [
            ./base
            ./hosts/laptop
            ./users/othi/nixos.nix
            ./users/othi/services.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = true;
                users.othi = import ./users/othi/home.nix;
                extraSpecialArgs.inputs = inputs // {
                  device = "laptop";
                  # TODO: any better way to do this?
                  rootPath = ./.;
                  # TODO: move this props to pass from ./users/othi
                  username = "othi";
                };
              };
            }
          ];
        };
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs.inputs = inputs;
          modules = [
            ./base
            ./devices/dogshitasslogitechmouse.nix
            ./hosts/pc
            ./users/othi/nixos.nix
            ./users/othi/services.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = true;
                users.othi = import ./users/othi/home.nix;
                extraSpecialArgs.inputs = inputs // {
                  device = "pc";
                  rootPath = ./.;
                  # TODO: move this props to pass from ./users/othi
                  username = "othi";
                };
              };
            }
          ];
        };
        pcremote = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs.inputs = inputs;
          modules = [
            ./base
            ./hosts/pcremote
            ./users/othi/nixos.nix
            ./users/othi/services.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = true;
                users.othi = import ./users/othi/home.nix;
                extraSpecialArgs.inputs = inputs // {
                  device = "pcremote";
                  rootPath = ./.;
                  # TODO: move this props to pass from ./users/othi
                  username = "othi";
                };
              };
            }
          ];
        };
      };
    };
}
