{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
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
                    inherit sshKind rootPath;
                    username = "othi";
                    extraModules = {
                      nvf = nvf.homeManagerModules.default;
                    };
                  };

                  users.othi = import ./users/othi;
                };
              }
            ];
          };
      };
    };
}
