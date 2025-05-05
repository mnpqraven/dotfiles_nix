{
  description = "Othi's system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    helix.url = "github:helix-editor/helix/master";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:jas-singhfsu/hyprpanel";
    kalker.url = "github:PaddiM8/kalker";
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
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
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
                };
              };
            }
          ];
        };
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
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
                };
              };
            }
          ];
        };
        pcremote = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
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
                };
              };
            }
          ];
        };
      };
    };
}
