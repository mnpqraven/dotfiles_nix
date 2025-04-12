{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

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
  };

  outputs = {
    nixpkgs,
    home-manager,
    nvf,
    hyprpanel,
    ...
  } @ inputs: {
    nixosConfigurations = {
      # NOTE: each key is a hostname, propagate this with different machines
      laptop = let
        sshKind = "id_ed25519";
        system = "x86_64-linux";
        device = "laptop";
        rootPath = ./.;
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
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
                backupFileExtension = "bak";
                extraSpecialArgs.inputs = {
                  # props
                  inherit sshKind rootPath device;
                  # pkgs
                  inherit hyprpanel nvf;
                  # TODO: move this props to pass from ./users/othi
                  username = "othi";
                };

                users.othi = import ./users/othi/home.nix;
              };
            }
          ];
        };
      pc = let
        sshKind = "id_ed25519";
        system = "x86_64-linux";
        device = "pc";
        rootPath = ./.;
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./base
            ./hosts/pc
            ./users/othi/nixos.nix
            ./users/othi/services.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = true;
                backupFileExtension = "bak";
                extraSpecialArgs.inputs = {
                  # props
                  inherit sshKind rootPath device;
                  # pkgs
                  inherit hyprpanel nvf;
                  # TODO: move this props to pass from ./users/othi
                  username = "othi";
                };

                users.othi = import ./users/othi/home.nix;
              };
            }
          ];
        };
    };
  };
}
