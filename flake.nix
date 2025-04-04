{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # helix editor, use the master branch
    helix.url = "github:helix-editor/helix/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # NOTE: each key is a hostname, propagate this with different machines
      laptop = let
        sshKind = "id_ed25519";
        rootPath = ./.;
      in nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./hosts/laptop
          ./users/othi/nixos.nix

          home-manager.nixosModules.home-manager
          {
            # home-manager
            home-manager = {
              useGlobalPkgs = false;
              useUserPackages = true;
              backupFileExtension = "bak";
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
              extraSpecialArgs.inputs = {
                inherit sshKind rootPath;
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
