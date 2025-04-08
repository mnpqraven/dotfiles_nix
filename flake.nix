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

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nvf,
      hyprpanel,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        # NOTE: each key is a hostname, propagate this with different machines
        laptop =
          let
            sshKind = "id_ed25519";
            rootPath = ./.;
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              # Import the previous configuration.nix we used,
              # so the old configuration file still takes effect
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
                    inherit sshKind rootPath;
                    # pkgs
                    inherit hyprpanel nvf;
                    username = "othi";
                  };

                  users.othi = import ./users/othi;
                };
              }
            ];
          };
      };
    };
}
